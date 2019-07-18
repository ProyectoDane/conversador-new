import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';
import 'package:flutter_syntactic_sorter/src/repository_exports.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept_helper.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/concept.dart';
import 'package:flutter_syntactic_sorter/src/model_exports.dart';

/// Repository for handling the getting and setting of stages
class StageRepository {
  /// Returns a StageRepository
  factory StageRepository() => _instance;
  StageRepository._internal();
  static final StageRepository _instance = StageRepository._internal();

  // MARK: - Stages

  /// Get random list of stages by count
  /// count: number of stages
  /// exceptionList: exception list of stages IDs
  Future<List<Stage>> getRandomStagesByCount(
      int count, List<int> exceptionList) async {

      final DatabaseProvider databaseProvider = DatabaseProvider();
      final List<Stage> stages = await StageDatabaseRepository(
      databaseProvider).getRandomStages(count, exceptionList);
      
      return _fillInStageData(stages, databaseProvider);
  }

  /// Get stage list by count
  /// The stages sentence data comes filled in
  Future<List<Stage>> getStageList(
    int count, int currentComplexity, int nextStageInCompIndex) async {

    final DatabaseProvider databaseProvider = DatabaseProvider();
    final List<Stage> stages = await _getPlainStageList(
      count, currentComplexity, nextStageInCompIndex, databaseProvider);

    return _fillInStageData(stages, databaseProvider);
  }

  /// Get stage list by count
  /// The stages are return in their basic format, without sentence data
  Future<List<Stage>> getPlainStageList(
    int count, int currentComplexity, int nextStageInCompIndex) async {

    final DatabaseProvider databaseProvider = DatabaseProvider();
    return _getPlainStageList(
      count, currentComplexity, nextStageInCompIndex, databaseProvider);
  }

  /// Returns an ordered list of stages with their plain information.
  /// This does not include the sentence data
  Future<List<Stage>> getAllPlainStageList() async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    final List<Stage> stages = await StageDatabaseRepository(
      databaseProvider).getAllOrdered();
    return stages;
  }

  /// Fills stages with their respective sentence data
  Future<List<Stage>> fillInStageData(List<Stage> stages) async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    return _fillInStageData(stages, databaseProvider);
  }

  //---------------------------------------------------------------
  // Private
  //---------------------------------------------------------------

  Future<List<Stage>> _getPlainStageList(
    int count, 
    int currentComplexity, 
    int nextStageInCompIndex, 
    DatabaseProvider databaseProvider) async {

    Complexity currentStageComplexity = Complexity.values[currentComplexity];
    int nextStageInComplexityIndex = nextStageInCompIndex;

    // Get stage list according to current complexity
    // The stages are sorted in complexity order, the lastStageInComplexityIndex
    // is used to determine where to continue taking stages from the same 
    // complexity level
    final List<Stage> stages = await StageDatabaseRepository(
      databaseProvider).getStages(
      currentStageComplexity.index, count, nextStageInComplexityIndex);
    
    // This line fixes lint warning
    final bool isQuotaMet = stages.length < count;
    if (isQuotaMet) {
      // If there not enought stages to meet the quota, stages from the next
      // complexity levels are obtained
      while (stages.length < count) {
        nextStageInComplexityIndex = 0;

        if (currentStageComplexity.index+1 == Complexity.values.length) {
          // If there are no more complexity levels, just send remaining stages
          break;
        }

        currentStageComplexity = Complexity.values[
        currentStageComplexity.index+1];
        final int remaining = count - stages.length;
      
        final List<Stage> addlStages = await StageDatabaseRepository(
        databaseProvider).getStages(
        currentStageComplexity.index, remaining, nextStageInComplexityIndex);
        stages.addAll(addlStages);
        nextStageInComplexityIndex = addlStages.length;
      }
    }

    return stages;
  }

  Future<List<Stage>> _fillInStageData(List<Stage> stages, 
    DatabaseProvider databaseProvider) async {
    // Get sentence list according to stage ids
    final List<int> stageIds = stages.map((Stage stage) => stage.id).toList();
    List<Sentence> sentences = await SentenceDatabaseRepository(
      databaseProvider).getByStageIds(stageIds);

    // Get subject list according to sentence ids
    final List<int> sentenceIds = 
      sentences.map((Sentence sentence) => sentence.id).toList();
    List<Subject> subjects = await SubjectDatabaseRepository(databaseProvider).
      getBySentenceIds(sentenceIds);

    // Get predicate list according to sentence ids
    List<Predicate> predicates = 
      await PredicateDatabaseRepository(databaseProvider).
        getBySentenceIds(sentenceIds);

    // Get entity list according to subject ids
    final List<int> subjectIds = 
      subjects.map((Subject subject) => subject.id).toList();
    final List<Entity> entities = 
      await EntityDatabaseRepository(databaseProvider).
      getBySubjectIds(subjectIds);

    // Get modifier list according to subject ids
    final List<Modifier> modifiers = 
      await ModifierDatabaseRepository(databaseProvider).
      getBySubjectIds(subjectIds);

    // Get actions list according to predicate ids
    final List<int> predicateIds = 
      predicates.map((Predicate predicate) => predicate.id).toList();
    final List<ActionVerb> actions = 
      await ActionDatabaseRepository(databaseProvider).
      getByPredicateIds(predicateIds);

    // Get complement list according to predicate ids
    final List<Complement> complements = 
      await ComplementDatabaseRepository(databaseProvider).
      getByPredicateIds(predicateIds);

    // Fill in subjects
    subjects = subjects.map((Subject subject) {
      // If the value is not null, the following is skipped
      if (subject.value == null) {
        final List<Concept> subjectEntities =
            entities.where((Entity e) => e.subjectId == subject.id).toList();
        final List<Concept> subjectModifiers =
            modifiers.where((Modifier m) => m.subjectId == subject.id).toList();
        final List<Concept> sum = <Concept>[];

        if (subjectEntities.length == 1) {
          // Case: modifier-entity, ex: "the cat"
          sum..addAll(subjectModifiers)..addAll(subjectEntities);
        } else {
          // Case : entity-modifier-entity, ex: "marie and clara"
          sum
            ..addAll(subjectEntities)
            ..insertAll(1, subjectModifiers);
        }

        // The object is recreated because the constructor creates data
        // from the children array.
        final Subject newSubject = Subject.containing(sum)
          ..sentenceId = subject.sentenceId;
        return newSubject;
      }

      return subject;
    }).toList();

    // Fill in predicates
    predicates = predicates.map((Predicate predicate) {
      // If the value is not null, the following is skipped
      if (predicate.value == null) {
        final List<Concept> predicateActions =
            actions.where((ActionVerb a) => 
              a.predicateId == predicate.id).toList();
        final List<Concept> predicateComplements = complements
            .where((Complement c) => c.predicateId == predicate.id)
            .toList();

        // Case: action-complement, ex: ... "eats noodles"
        final List<Concept> sum = <Concept>[]
          ..addAll(predicateActions)
          ..addAll(predicateComplements);

        // The object is recreated because the constructor creates data
        // from the children array.
        final Predicate newPredicate = Predicate.containing(sum)
          ..sentenceId = predicate.sentenceId;
        return newPredicate;
      }

      return predicate;
    }).toList();

    // Fill in sentences
    sentences = sentences.map((Sentence sentence) {
      sentence
        ..subject = subjects
            .where((Subject s) => s.sentenceId == sentence.id)
            .toList()
            .first
        ..predicate = predicates
            .where((Predicate p) => p.sentenceId == sentence.id)
            .toList()
            .first;

      return sentence;
    }).toList();

    // Fill in stages
    return stages.map((Stage stage) {
      stage
        ..sentence = sentences
            .where((Sentence s) => s.stageId == stage.id)
            .toList()
            .first
        ..maximumDepth = ConceptHelper.getSentenceDepth(stage.sentence);
      return stage;
    }).toList();
  }  
}

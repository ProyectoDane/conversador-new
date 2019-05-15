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

  List<Stage> _dbStages;

  // MARK: - Stages

  /// Get a number of Stages from the list with difficulty in ascending order.
  /// count: number of stages
  /// indexOffset: index from where the stage count will begin
  Future<List<Stage>> getStagesByCount(int count, int indexOffset) async {
    final List<Stage> stages = await _completeStageList();

    if (indexOffset > stages.length) {
      return <Stage>[];
    }

    final List<Stage> selectedItems =
        stages.sublist(indexOffset, indexOffset + count);
    return selectedItems;
  }

  /// Get random list of stages by count
  /// count: number of stages
  /// exceptionList: exception list of stages IDs
  Future<List<Stage>> getRandomStagesByCount(
      int count, List<int> exceptionList) async {
    final List<Stage> stages = await _completeStageList()
      // Removes previously used stages by ID
      ..removeWhere((Stage stage) => exceptionList.contains(stage.id))
      // Randomly scramble the remaining list
      ..shuffle();
    // Get the ammount of elements wanted
    final List<Stage> shuffledList = stages.sublist(0, count);
    return shuffledList;
  }

  /// TODO: Combine default stages with user generated stages
  Future<List<Stage>> _completeStageList() async {
    final List<Stage> easyStages =
        await _getStagesOfComplexity(Complexity.easy);
    final List<Stage> normalStages =
        await _getStagesOfComplexity(Complexity.normal);
    final List<Stage> hardStages =
        await _getStagesOfComplexity(Complexity.hard);
    final List<Stage> expertStages =
        await _getStagesOfComplexity(Complexity.expert);

    final List<Stage> stages = easyStages
      ..addAll(normalStages)
      ..addAll(hardStages)
      ..addAll(expertStages);

    return stages;
  }

  /// Get all the stages that have a certain mentalComplexity
  Future<List<Stage>> _getStagesOfComplexity(
      Complexity mentalComplexity) async {
    final List<Stage> defaultStages = await _defaultStageList();
    final List<Stage> stages = defaultStages
        .where((Stage stage) => stage.mentalComplexity == mentalComplexity)
        .toList()
          ..sort((Stage stage1, Stage stage2) =>
              stage1.complexityOrder.compareTo(stage2.complexityOrder));

    return stages;
  }

  Future<List<Stage>> _defaultStageList() async {
    if (_dbStages != null) {
      return _dbStages;
    }

    final DatabaseProvider _databaseProvider = DatabaseProvider();

    final List<Action> actions =
        await ActionDatabaseRepository(_databaseProvider).getAll();
    final List<Complement> complements =
        await ComplementDatabaseRepository(_databaseProvider).getAll();
    final List<Entity> entities =
        await EntityDatabaseRepository(_databaseProvider).getAll();
    final List<Modifier> modifiers =
        await ModifierDatabaseRepository(_databaseProvider).getAll();
    List<Predicate> predicates =
        await PredicateDatabaseRepository(_databaseProvider).getAll();
    List<Sentence> sentences =
        await SentenceDatabaseRepository(_databaseProvider).getAll();
    List<Subject> subjects =
        await SubjectDatabaseRepository(_databaseProvider).getAll();

    _dbStages = await StageDatabaseRepository(_databaseProvider).getAll();

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
            actions.where((Action a) => a.predicateId == predicate.id).toList();
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
    return _dbStages = _dbStages.map((Stage stage) {
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

import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/src/model_exports.dart';
import 'package:flutter_syntactic_sorter/src/repository_exports.dart';

/// Library for creating and preloading the app's database initial data.
/// This should be deprecated in a future build

final DatabaseProvider _databaseProvider = DatabaseProvider();
final ActionDatabaseRepository _actionRepository =
    ActionDatabaseRepository(_databaseProvider);
final ComplementDatabaseRepository _complementRepository =
    ComplementDatabaseRepository(_databaseProvider);
final MentalComplexityDatabaseRepository _complexityRepository =
    MentalComplexityDatabaseRepository(_databaseProvider);
final EntityDatabaseRepository _entityRepository =
    EntityDatabaseRepository(_databaseProvider);
final ModifierDatabaseRepository _modifierRepository =
    ModifierDatabaseRepository(_databaseProvider);
final PredicateDatabaseRepository _predicateRepository =
    PredicateDatabaseRepository(_databaseProvider);
final SentenceDatabaseRepository _sentenceRepository =
    SentenceDatabaseRepository(_databaseProvider);
final StageDatabaseRepository _stageRepository =
    StageDatabaseRepository(_databaseProvider);
final SubjectDatabaseRepository _subjectRepository =
    SubjectDatabaseRepository(_databaseProvider);

/// Pre loads the game initial data into the database
Future<void> preloadData() async {
  // Insert stage difficulties
  await _complexityRepository.bulkInsert(<MentalComplexity>[
    MentalComplexity(id: 1, description: 'Easy'),
    MentalComplexity(id: 2, description: 'Normal'),
    MentalComplexity(id: 3, description: 'Hard'),
    MentalComplexity(id: 4, description: 'Expert'),
  ]);

  // Insert stages
  await _stageRepository.bulkInsert(<Stage>[
    Stage.data(
      id: 1,
      mentalComplexity: 1,
      backgroundUri: 'assets/images/game/gaston_corre.jpg',
    ),
    Stage.data(
      id: 2,
      mentalComplexity: 1,
      backgroundUri: 'assets/images/game/la_abuela_pinta.jpg',
    ),
    Stage.data(
      id: 3,
      mentalComplexity: 1,
      backgroundUri: 'assets/images/game/el_perro_come.jpg',
    ),
    Stage.data(
      id: 4,
      mentalComplexity: 1,
      backgroundUri: 'assets/images/game/pelusa_ronronea.jpg',
    ),
    Stage.data(
      id: 5,
      mentalComplexity: 2,
      backgroundUri: 'assets/images/game/kim_come_fideos.jpg',
    ),
    Stage.data(
      id: 6,
      mentalComplexity: 2,
      backgroundUri: 'assets/images/game/maria_y_alan_rien.jpg',
    ),
    Stage.data(
      id: 7,
      mentalComplexity: 2,
      backgroundUri: 'assets/images/game/el_ninio_salta_la_soga.jpg',
    ),
    Stage.data(
      id: 8,
      mentalComplexity: 2,
      backgroundUri: 'assets/images/game/mariana_y_carla_juegan_contentas.jpg',
    ),
    Stage.data(
      id: 9,
      mentalComplexity: 3,
      backgroundUri: 'assets/images/game/las_chicas_juegan_al_futbol.jpg',
    ),
    Stage.data(
      id: 10,
      mentalComplexity: 4,
      backgroundUri: 'assets/images/game/juan_suenia_con_su_perro.jpg',
    ),
  ]);

  // Insert sentences
  await _sentenceRepository.bulkInsert(<Sentence>[
    Sentence.data(id: 1, stageId: 1),
    Sentence.data(id: 2, stageId: 2),
    Sentence.data(id: 3, stageId: 3),
    Sentence.data(id: 4, stageId: 4),
    Sentence.data(id: 5, stageId: 5),
    Sentence.data(id: 6, stageId: 6),
    Sentence.data(id: 7, stageId: 7),
    Sentence.data(id: 8, stageId: 8),
    Sentence.data(id: 9, stageId: 9),
    Sentence.data(id: 10, stageId: 10),
  ]);

  // Insert subjects
  await _subjectRepository.bulkInsert(<Subject>[
    Subject.data(id: 1, sentenceId: 1, value: 'Gastón'),
    Subject.data(id: 2, sentenceId: 2),
    Subject.data(id: 3, sentenceId: 3),
    Subject.data(id: 4, sentenceId: 4, value: 'Pelusa'),
    Subject.data(id: 5, sentenceId: 5, value: 'Kim'),
    Subject.data(id: 6, sentenceId: 6),
    Subject.data(id: 7, sentenceId: 7),
    Subject.data(id: 8, sentenceId: 8),
    Subject.data(id: 9, sentenceId: 9),
    Subject.data(id: 10, sentenceId: 10, value: 'Juan'),
  ]);

  // Insert predicates
  await _predicateRepository.bulkInsert(<Predicate>[
    Predicate.data(id: 1, value: 'corre', sentenceId: 1),
    Predicate.data(id: 2, value: 'pinta', sentenceId: 2),
    Predicate.data(id: 3, value: 'come', sentenceId: 3),
    Predicate.data(id: 4, value: 'ronronea', sentenceId: 4),
    Predicate.data(id: 5, sentenceId: 5),
    Predicate.data(id: 6, value: 'ríen', sentenceId: 6),
    Predicate.data(id: 7, sentenceId: 7),
    Predicate.data(id: 8, sentenceId: 8),
    Predicate.data(id: 9, sentenceId: 9),
    Predicate.data(id: 10, sentenceId: 10),
  ]);

  // Insert entities
  await _entityRepository.bulkInsert(<Entity>[
    Entity.data(id: 1, subjectId: 2, value: 'abuela'),
    Entity.data(id: 2, subjectId: 3, value: 'perro'),
    Entity.data(id: 3, subjectId: 6, value: 'Maria'),
    Entity.data(id: 4, subjectId: 6, value: 'Alan'),
    Entity.data(id: 5, subjectId: 7, value: 'niño'),
    Entity.data(id: 6, subjectId: 8, value: 'Mariana'),
    Entity.data(id: 7, subjectId: 8, value: 'Carla'),
    Entity.data(id: 8, subjectId: 9, value: 'chicas'),
  ]);

  // Insert modifiers
  await _modifierRepository.bulkInsert(<Modifier>[
    Modifier.data(id: 1, value: 'La', subjectId: 2),
    Modifier.data(id: 2, value: 'El', subjectId: 3),
    Modifier.data(id: 3, value: 'y', subjectId: 6),
    Modifier.data(id: 4, value: 'El', subjectId: 7),
    Modifier.data(id: 5, value: 'y', subjectId: 8),
    Modifier.data(id: 6, value: 'Las', subjectId: 9),
  ]);

  // Insert actions
  await _actionRepository.bulkInsert(<Action>[
    Action.data(id: 1, value: 'come', predicateId: 5),
    Action.data(id: 2, value: 'salta', predicateId: 7),
    Action.data(id: 3, value: 'juegan', predicateId: 8),
    Action.data(id: 4, value: 'juegan', predicateId: 9),
    Action.data(id: 5, value: 'sueña', predicateId: 10),
  ]);
  // Insert complements
  await _complementRepository.bulkInsert(<Complement>[
    Complement.data(id: 1, value: 'fideos', predicateId: 5),
    Complement.data(id: 2, value: 'la soga', predicateId: 7),
    Complement.data(id: 3, value: 'contentas', predicateId: 8),
    Complement.data(id: 4, value: 'al fútbol', predicateId: 9),
    Complement.data(id: 5, value: 'con su perro', predicateId: 10),
  ]);
}

/// Print the database on the debug console
Future<void> printDB() async {
  await _actionRepository.getAll().then((List<Action> result) {
    for (final Action action in result) {
      print('''
            Table: Action 
            - id: ${action.id} 
            - value: ${action.value}
            ''');
    }
  });
  await _complementRepository.getAll().then((List<Complement> result) {
    for (final Complement complement in result) {
      print('''
            Table: Complement 
            - id: ${complement.id} 
            - value: ${complement.value}
            ''');
    }
  });
  await _complexityRepository.getAll().then((List<MentalComplexity> result) {
    for (final MentalComplexity complexity in result) {
      print('''
            Table: Complexity 
            - id: ${complexity.id} 
            - value: ${complexity.description}
            ''');
    }
  });
  await _entityRepository.getAll().then((List<Entity> result) {
    for (final Entity entity in result) {
      print('''
            Table: Entity 
            - id: ${entity.id} 
            - value: ${entity.value}
            ''');
    }
  });
  await _modifierRepository.getAll().then((List<Modifier> result) {
    for (final Modifier modifier in result) {
      print('''
            Table: Modifier 
            - id: ${modifier.id} 
            - value: ${modifier.value}
            ''');
    }
  });
  await _predicateRepository.getAll().then((List<Predicate> result) {
    for (final Predicate predicate in result) {
      print('''
            Table: Predicate 
            - id: ${predicate.id} 
            - value: ${predicate.value}
            ''');
    }
  });
  await _sentenceRepository.getAll().then((List<Sentence> result) {
    for (final Sentence sentence in result) {
      print('''
            Table: Sentence 
            - id: ${sentence.id} 
            - stage id: ${sentence.stageId}
            ''');
    }
  });
  await _stageRepository.getAll().then((List<Stage> result) {
    for (final Stage stage in result) {
      print('''
            Table: Stage 
            - id: ${stage.id} 
            - difficulty: ${stage.mentalComplexity} 
            - background: ${stage.backgroundUri}
            ''');
    }
  });
  await _subjectRepository.getAll().then((List<Subject> result) {
    for (final Subject subject in result) {
      print('''
            Table: Subject 
            - id: ${subject.id} 
            - value: ${subject.value}
            ''');
    }
  });
}

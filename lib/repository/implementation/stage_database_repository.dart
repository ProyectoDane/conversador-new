import 'dart:ui';
import 'package:flutter_syntactic_sorter/data_access/dao/language_dao.dart';
import 'package:flutter_syntactic_sorter/util/lang_helper.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/stage_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class StageDatabaseRepository implements Repository<Stage> {
  /// Repository implementation constructor
  StageDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final StageDao dao = StageDao();

  final LanguageDao _langDao = LanguageDao();

  static Locale _locale;

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Stage> insert(Stage stage) async {
    final Database db = await databaseProvider.db();
    stage.id = await db.insert(dao.tableName, dao.toMap(stage));
    return stage;
  }

  @override
  Future<void> bulkInsert(List<Stage> stages) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Stage stage in stages) {
      batch.insert(dao.tableName, dao.toMap(stage));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Stage> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[
        dao.columnId,
        dao.columnComplexityId,
        dao.columnBackgroundUri,
      ],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Stage>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }

  /// Get full ordered list of stages
  Future<List<Stage>> getAllOrdered() async {
    final Database db = await databaseProvider.db();
    _locale = _locale ?? await fetchLocale();

    final String query = '''
    SELECT t.${dao.columnId}, t.${dao.columnComplexityId}, t.${dao.columnComplexityOrder}, t.${dao.columnBackgroundUri}, tr.${dao.columnValue}
    FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${_langDao.tableNameLanguage} l
	  WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	  AND tr.${_langDao.foreignColumnId} = l.${_langDao.columnNameId}
    AND l.name = '${_locale.languageCode}'
    ORDER BY ${dao.columnComplexityId}, ${dao.columnComplexityOrder} ASC;
    ''';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    
    return dao.fromList(maps);
  }

  /// Get limited stage list according to complexity
  /// The list is ordered by ID, the offset can be used
  /// to avoid getting previously obtainted items.
  Future<List<Stage>> getStages(int complexity, int count, int offset) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName, 
      where: '${dao.columnComplexityId} = ?',
      whereArgs: <int>[complexity],
      orderBy: '${dao.columnComplexityOrder} ASC',
      limit: count,
      offset:  offset);
    return dao.fromList(maps);
  }

    /// Get a random list of stages
  Future<List<Stage>> getRandomStages(int count, List<int>exceptions) async {
    final Database db = await databaseProvider.db();
    List<Map<String, dynamic>> maps;

    if (exceptions.isNotEmpty) {
      final String exceptionWhere = 
        exceptions.map((int _) => '${dao.columnId} != ?')
        .toList().join(' AND ');

      maps = await db.query(
        dao.tableName, 
        where: exceptionWhere,
        whereArgs: exceptions,
        orderBy: 'RANDOM()',
        limit: count,);
    } else {
      maps = await db.query(
        dao.tableName, 
        orderBy: 'RANDOM()',
        limit: count,);
    }

    return dao.fromList(maps);
  }
}

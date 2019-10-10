import 'package:flutter_syntactic_sorter/data_access/dao/level_dao.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

/// Repository implementation class
class LevelDatabaseRepository implements Repository<Level> {
  /// Repository implementation constructor
  LevelDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final LevelDao dao = LevelDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Level> insert(Level level) async {
    final Database db = await databaseProvider.db();
    level.id = await db.insert(dao.tableName, dao.toMap(level));
    return level;
  }

  @override
  Future<void> bulkInsert(List<Level> levels) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Level level in levels) {
      batch.insert(dao.tableName, dao.toMap(level));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Level> getById(int id) async {
    final Database db = await databaseProvider.db();
    final String query = '''
    SELECT *
    FROM ${dao.tableName}
    WHERE ${dao.columnId} = $id;
    ''';
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    if (maps.isNotEmpty) {
      final String stageQuery = '''
      SELECT ${dao.columnStageIdSt}
      FROM ${dao.tableNameSt}
      WHERE ${dao.columnLevelIdSt} = $id;
      ''';
      final List<Map<String, dynamic>> stageMaps = 
        await db.rawQuery(stageQuery);

      final Map<String, dynamic> levelQuery = maps.first;
      final List<int> stageList = stageMaps
        .map<int>((Map<String, dynamic> _) => _['stage_id'] as int)
        .toList();
      final Map<String,dynamic> aux = 
        <String,dynamic>{dao.stageIdListKey:stageList}
      ..addAll(levelQuery);
      return dao.fromMap(aux);
    } else {
      return null;
    }
  }

  @override
  Future<List<Level>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }

  /// Get total level count
  Future<int>getLevelCount() async {
    final Database db = await databaseProvider.db();
    final int count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ${dao.tableName}'));
    return count;
  }

  /// Gets level by stage id contained by it
  Future<Level> getByStageId(int stageId) async {
    final Database db = await databaseProvider.db();
    final String query = '''
    SELECT ${dao.columnLevelIdSt}
    FROM ${dao.tableNameSt}
    WHERE ${dao.columnStageIdSt} = $stageId;
    ''';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.isNotEmpty ? 
      getById(maps.first[dao.columnLevelIdSt] as int) : null;
  }
}
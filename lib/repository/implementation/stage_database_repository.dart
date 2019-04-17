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
        dao.columnMentalComplexityId,
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
}

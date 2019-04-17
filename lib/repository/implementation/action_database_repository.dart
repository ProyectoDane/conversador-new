import 'package:flutter_syntactic_sorter/data_access/dao/action_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class ActionDatabaseRepository implements Repository<Action> {
  /// Repository implementation constructor
  ActionDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final ActionDao dao = ActionDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Action> insert(Action action) async {
    final Database db = await databaseProvider.db();
    action.id = await db.insert(dao.tableName, dao.toMap(action));
    return action;
  }

  @override
  Future<void> bulkInsert(List<Action> actions) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Action action in actions) {
      batch.insert(dao.tableName, dao.toMap(action));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Action> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[dao.columnId, dao.columnValue],
      where: '${dao.columnId} = ?',
      whereArgs: List<dynamic>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Action>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

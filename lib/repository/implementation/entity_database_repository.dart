import 'package:flutter_syntactic_sorter/data_access/dao/entity_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class EntityDatabaseRepository implements Repository<Entity> {
  /// Repository implementation constructor
  EntityDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final EntityDao dao = EntityDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Entity> insert(Entity entity) async {
    final Database db = await databaseProvider.db();
    entity.id = await db.insert(dao.tableName, dao.toMap(entity));
    return entity;
  }

  @override
  Future<void> bulkInsert(List<Entity> entities) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Entity entity in entities) {
      batch.insert(dao.tableName, dao.toMap(entity));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Entity> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[dao.columnId, dao.columnValue, dao.columnSubjectId],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Entity>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

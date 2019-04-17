import 'package:flutter_syntactic_sorter/data_access/dao/modifier_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class ModifierDatabaseRepository implements Repository<Modifier> {
  /// Repository implementation constructor
  ModifierDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final ModifierDao dao = ModifierDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Modifier> insert(Modifier modifier) async {
    final Database db = await databaseProvider.db();
    modifier.id = await db.insert(dao.tableName, dao.toMap(modifier));
    return modifier;
  }

  @override
  Future<void> bulkInsert(List<Modifier> modifiers) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Modifier modifier in modifiers) {
      batch.insert(dao.tableName, dao.toMap(modifier));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Modifier> getById(int id) async {
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
  Future<List<Modifier>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

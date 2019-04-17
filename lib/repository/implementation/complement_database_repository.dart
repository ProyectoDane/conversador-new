import 'package:flutter_syntactic_sorter/data_access/dao/complement_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class ComplementDatabaseRepository implements Repository<Complement> {
  /// Repository implementation constructor
  ComplementDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final ComplementDao dao = ComplementDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Complement> insert(Complement complement) async {
    final Database db = await databaseProvider.db();
    complement.id = await db.insert(dao.tableName, dao.toMap(complement));
    return complement;
  }

  @override
  Future<void> bulkInsert(List<Complement> complements) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Complement complement in complements) {
      batch.insert(dao.tableName, dao.toMap(complement));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Complement> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[dao.columnId, dao.columnValue],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Complement>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

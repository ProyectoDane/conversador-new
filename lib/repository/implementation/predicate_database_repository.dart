import 'package:flutter_syntactic_sorter/data_access/dao/predicate_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class PredicateDatabaseRepository implements Repository<Predicate> {
  /// Repository implementation constructor
  PredicateDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final PredicateDao dao = PredicateDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Predicate> insert(Predicate predicate) async {
    final Database db = await databaseProvider.db();
    predicate.id = await db.insert(dao.tableName, dao.toMap(predicate));
    return predicate;
  }

  @override
  Future<void> bulkInsert(List<Predicate> predicates) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Predicate predicate in predicates) {
      batch.insert(dao.tableName, dao.toMap(predicate));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Predicate> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[dao.columnId, dao.columnValue, dao.columnSentenceId],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Predicate>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

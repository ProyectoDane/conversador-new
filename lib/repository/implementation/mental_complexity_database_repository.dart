import 'package:flutter_syntactic_sorter/data_access/dao/mental_complexity_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class MentalComplexityDatabaseRepository
    implements Repository<MentalComplexity> {
  /// Repository implementation constructor
  MentalComplexityDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final MentalComplexityDao dao = MentalComplexityDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<MentalComplexity> insert(MentalComplexity difficulty) async {
    final Database db = await databaseProvider.db();
    difficulty.id = await db.insert(dao.tableName, dao.toMap(difficulty));
    return difficulty;
  }

  @override
  Future<void> bulkInsert(List<MentalComplexity> complexities) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final MentalComplexity complexity in complexities) {
      batch.insert(dao.tableName, dao.toMap(complexity));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<MentalComplexity> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[dao.columnId, dao.columnDescription],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<MentalComplexity>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

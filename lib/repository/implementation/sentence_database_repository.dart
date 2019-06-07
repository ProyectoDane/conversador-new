import 'package:flutter_syntactic_sorter/data_access/dao/sentence_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class SentenceDatabaseRepository implements Repository<Sentence> {
  /// Repository implementation constructor
  SentenceDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final SentenceDao dao = SentenceDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Sentence> insert(Sentence sentence) async {
    final Database db = await databaseProvider.db();
    sentence.id = await db.insert(dao.tableName, dao.toMap(sentence));
    return sentence;
  }

  @override
  Future<void> bulkInsert(List<Sentence> sentences) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Sentence sentence in sentences) {
      batch.insert(dao.tableName, dao.toMap(sentence));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Sentence> getById(int id) async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName,
      columns: <String>[
        dao.columnId,
        dao.columnStageId,
      ],
      where: '${dao.columnId} = ?',
      whereArgs: List<int>(id),
    );
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  /// Get sentences according to stage id list
  Future<List<Sentence>> getByStageIds(List<int> stageIds) async {
    // generates a WHERE search condition for each stage id
    final String whereString = 
      stageIds.map((int _)=>'${dao.columnStageId} = ?').toList().join(' OR ');

    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(
      dao.tableName, 
      where: whereString,
      whereArgs: stageIds,);
    return dao.fromList(maps);
  }

  @override
  Future<List<Sentence>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

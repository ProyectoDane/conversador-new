import 'package:flutter_syntactic_sorter/data_access/dao/subject_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class SubjectDatabaseRepository implements Repository<Subject> {
  /// Repository implementation constructor
  SubjectDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final SubjectDao dao = SubjectDao();

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<Subject> insert(Subject subject) async {
    final Database db = await databaseProvider.db();
    subject.id = await db.insert(dao.tableName, dao.toMap(subject));
    return subject;
  }

  @override
  Future<void> bulkInsert(List<Subject> subjects) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final Subject subject in subjects) {
      batch.insert(dao.tableName, dao.toMap(subject));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Subject> getById(int id) async {
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
  Future<List<Subject>> getAll() async {
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}

import 'dart:ui';

import 'package:flutter_syntactic_sorter/data_access/dao/language_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/subject_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:flutter_syntactic_sorter/util/lang_helper.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class SubjectDatabaseRepository implements Repository<Subject> {
  /// Repository implementation constructor
  SubjectDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final SubjectDao dao = SubjectDao();

  final LanguageDao _langDao = LanguageDao();

  static Locale _locale;

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
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdQuery(id, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Subject>> getAll() async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getAllQuery(dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }

  /// Get subjects by sentece id list
  Future<List<Subject>> getBySentenceIds(List<int> sentenceIds) async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdListQuery(sentenceIds, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }
}

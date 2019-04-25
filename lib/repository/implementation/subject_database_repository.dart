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
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(_getByIdQuery(id));
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Subject>> getAll() async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final List<Map<String, dynamic>> maps = await db.rawQuery(_getAllQuery);
    return dao.fromList(maps);
  }

  String get _getAllQuery => '''
  SELECT t.${dao.columnId}, t.${dao.columnSentenceId}, tr.${dao.columnValue}
  FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${_langDao.tableNameLanguage} l
	WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	AND tr.${_langDao.foreignColumnId} = l.${_langDao.columnNameId}
  AND l.name = '${_locale.languageCode}';
  ''';

  String _getByIdQuery(int id) => '''
  SELECT t.${dao.columnId}, t.${dao.columnSentenceId}, tr.${dao.columnValue}
  FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${_langDao.tableNameLanguage} l
	WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	AND tr.${_langDao.foreignColumnId} = l.${_langDao.columnNameId}
  AND l.name = '${_locale.languageCode}'
  AND t.id = $id;
  ''';
}

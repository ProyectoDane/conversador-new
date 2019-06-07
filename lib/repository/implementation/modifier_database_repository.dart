import 'dart:ui';

import 'package:flutter_syntactic_sorter/data_access/dao/language_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/modifier_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:flutter_syntactic_sorter/util/lang_helper.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class ModifierDatabaseRepository implements Repository<Modifier> {
  /// Repository implementation constructor
  ModifierDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final ModifierDao dao = ModifierDao();

  final LanguageDao _langDao = LanguageDao();

  static Locale _locale;

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
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdQuery(
      id, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<Modifier>> getAll() async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getAllQuery(dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }

  /// Get modifiers by subject id list
  Future<List<Modifier>> getBySubjectIds(List<int> subjectIds) async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdListQuery(
      subjectIds, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }
}

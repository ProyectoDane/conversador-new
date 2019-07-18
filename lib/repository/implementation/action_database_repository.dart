import 'dart:ui';

import 'package:flutter_syntactic_sorter/data_access/dao/action_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/language_dao.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';
import 'package:flutter_syntactic_sorter/repository/interface/repository.dart';
import 'package:flutter_syntactic_sorter/util/lang_helper.dart';
import 'package:sqflite/sqlite_api.dart';

/// Repository implementation class
class ActionDatabaseRepository implements Repository<ActionVerb> {
  /// Repository implementation constructor
  ActionDatabaseRepository(this.databaseProvider);

  /// Dao instance for the repository
  final ActionDao dao = ActionDao();

  final LanguageDao _langDao = LanguageDao();

  static Locale _locale;

  @override
  DatabaseProvider databaseProvider;

  @override
  Future<ActionVerb> insert(ActionVerb action) async {
    final Database db = await databaseProvider.db();
    action.id = await db.insert(dao.tableName, dao.toMap(action));
    return action;
  }

  @override
  Future<void> bulkInsert(List<ActionVerb> actions) async {
    final Database db = await databaseProvider.db();
    final Batch batch = db.batch();
    for (final ActionVerb action in actions) {
      batch.insert(dao.tableName, dao.toMap(action));
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<ActionVerb> getById(int id) async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdQuery(id, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.isNotEmpty ? dao.fromMap(maps.first) : null;
  }

  @override
  Future<List<ActionVerb>> getAll() async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getAllQuery(dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }

  /// Get actions by predicate id list
  Future<List<ActionVerb>> getByPredicateIds(List<int> predicateIds) async {
    _locale = _locale ?? await fetchLocale();
    final Database db = await databaseProvider.db();
    final String query = getByIdListQuery(predicateIds, dao, _langDao, _locale);
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return dao.fromList(maps);
  }
}

import 'package:flutter/rendering.dart';
import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/data_access/dao/language_dao.dart';

/// Abstract repository for the generic concept class
abstract class Repository<T> {
  /// Database provider
  DatabaseProvider databaseProvider;

  /// Inserts data form an object into the table
  Future<T> insert(T concept);

  /// Inserts a set of data from a list into the table
  Future<void> bulkInsert(List<T> concepts);

  /// Retrieves the table data into an object
  Future<T> getById(int id);

  /// Retrieves all table data into an list
  Future<List<T>> getAll();
}

/// Gets query for all concept list, according to expecified conditions
String getAllQuery(
  ConceptDao dao,
  LanguageDao langDao,
  Locale locale) 
  => '''
  SELECT t.${dao.columnId}, t.${dao.columnParentId}, tr.${dao.columnValue}
  FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${langDao.tableNameLanguage} l
	WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	AND tr.${langDao.foreignColumnId} = l.${langDao.columnNameId}
  AND l.name = '${locale.languageCode}';
  ''';

/// Gets specific concept item, according to expecified conditions
String getByIdQuery(
  int id,
  ConceptDao dao,
  LanguageDao langDao,
  Locale locale) 
  => '''
  SELECT t.${dao.columnId}, t.${dao.columnParentId}, tr.${dao.columnValue}
  FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${langDao.tableNameLanguage} l
	WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	AND tr.${langDao.foreignColumnId} = l.${langDao.columnNameId}
  AND l.name = '${locale.languageCode}'
  AND t.id = $id;
  ''';

/// Gets query for concepts according to id list
  String getByIdListQuery(
    List<int> ids, 
    ConceptDao dao,
    LanguageDao langDao,
    Locale locale) { 
    final String idsWhereCondition = ids.map((int id) 
      => 't.${dao.columnParentId} = $id').toList().join(' OR ');

    return '''
  SELECT t.${dao.columnId}, t.${dao.columnParentId}, tr.${dao.columnValue}
  FROM ${dao.tableName} t, ${dao.tableNameTr} tr, ${langDao.tableNameLanguage} l
	WHERE t.${dao.columnId} = tr.${dao.columnIdSource}
	AND tr.${langDao.foreignColumnId} = l.${langDao.columnNameId}
  AND l.name = '${locale.languageCode}'
  AND ($idsWhereCondition);
  ''';
  }
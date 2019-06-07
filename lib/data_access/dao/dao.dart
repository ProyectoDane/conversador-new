/// Abstract generic DAO class
abstract class Dao<T> {
  /// Create table query
  String get createTableQuery;

  /// Creates a generic class from a key/value pair map
  T fromMap(Map<String, dynamic> query);

  /// Maps a list of queries to a list of objects
  List<T> fromList(List<Map<String, dynamic>> query);

  /// Creates a map from the class properties
  Map<String, dynamic> toMap(T object);
}

/// Absctact Concept DAO class
abstract class ConceptDao {
  /// The name of the table
  String get tableName;

  /// The name of the translation table
  String get tableNameTr;

  /// id column name
  String get columnId;

  /// untranslated table id column name
  String get columnIdSource;

  /// value column name
  String get columnValue;

  /// parent column parent relation id
  String get columnParentId;
}

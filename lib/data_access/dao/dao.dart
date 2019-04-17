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

import 'package:flutter_syntactic_sorter/data_access/database_provider.dart';

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

import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';

/// Database table for the Complement class
class ComplementDao implements Dao<Complement> {
  /// Database table class constructor
  ComplementDao();

  /// The name of the table
  final String tableName = 'complement';

  /// The name of the translation table
  final String tableNameTr = 'complement_tr';

  /// id column name
  final String columnId = 'id';

  /// untranslated table id column name
  final String columnIdSource = 'complement_id';

  /// value column name
  final String columnValue = 'value';

  /// predicate id column name
  final String columnPredicateId = 'predicate_id';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnValue text not null,
      $columnPredicateId integer not null,
      FOREIGN KEY ($columnPredicateId) REFERENCES predicate (id))
    ''';

  @override
  Complement fromMap(Map<String, dynamic> query) => Complement.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        predicateId: query[columnPredicateId] as int,
      );
  @override
  Map<String, dynamic> toMap(Complement object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnPredicateId: object.predicateId,
      };

  @override
  List<Complement> fromList(List<Map<String, dynamic>> query) {
    final List<Complement> complements = <Complement>[];
    for (final Map<String, dynamic> map in query) {
      complements.add(fromMap(map));
    }
    return complements;
  }
}

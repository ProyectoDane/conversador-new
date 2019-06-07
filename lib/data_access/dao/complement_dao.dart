import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/complement.dart';

/// Database table for the Complement class
class ComplementDao implements Dao<Complement>, ConceptDao {
  /// Database table class constructor
  ComplementDao();

  @override
  String get tableName => 'complement';

  @override
  String get tableNameTr => 'complement_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'complement_id';

  @override
  String get columnValue => 'value';

  @override
  String get columnParentId => 'predicate_id';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnValue text not null,
      $columnParentId integer not null,
      FOREIGN KEY ($columnParentId) REFERENCES predicate (id))
    ''';

  @override
  Complement fromMap(Map<String, dynamic> query) => Complement.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        predicateId: query[columnParentId] as int,
      );
  @override
  Map<String, dynamic> toMap(Complement object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.predicateId,
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

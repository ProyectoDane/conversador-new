import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';

/// Database table for the Predicate class
class PredicateDao implements Dao<Predicate>, ConceptDao {
  /// Database table class constructor
  PredicateDao();

  @override
  String get tableName => 'predicate';

  @override
  String get tableNameTr => 'predicate_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'predicate_id';

  @override
  String get columnValue => 'value';

  @override
  String get columnParentId => 'sentence_id';

  @override
  String get createTableQuery => '''
  CREATE TABLE IF NOT EXISTS $tableName ( 
    $columnId integer primary key, 
    $columnValue text,
    $columnParentId integer not null,
    FOREIGN KEY ($columnParentId) REFERENCES sentence (id))
    ''';

  @override
  Predicate fromMap(Map<String, dynamic> query) => Predicate.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        sentenceId: query[columnParentId] as int,
      );

  @override
  Map<String, dynamic> toMap(Predicate object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.sentenceId,
      };

  @override
  List<Predicate> fromList(List<Map<String, dynamic>> query) {
    final List<Predicate> predicates = <Predicate>[];
    for (final Map<String, dynamic> map in query) {
      predicates.add(fromMap(map));
    }
    return predicates;
  }
}

import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/predicate.dart';

/// Database table for the Predicate class
class PredicateDao implements Dao<Predicate> {
  /// Database table class constructor
  PredicateDao();

  /// The name of the table
  final String tableName = 'predicate';

  /// id column name
  final String columnId = 'id';

  /// value column name
  final String columnValue = 'value';

  /// sentence id column name
  final String columnSentenceId = 'sentence_id';

  @override
  String get createTableQuery => '''
  CREATE TABLE IF NOT EXISTS $tableName ( 
    $columnId integer primary key, 
    $columnValue text,
    $columnSentenceId integer not null,
    FOREIGN KEY ($columnSentenceId) REFERENCES sentence (id))
    ''';

  @override
  Predicate fromMap(Map<String, dynamic> query) => Predicate.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        sentenceId: query[columnSentenceId] as int,
      );

  @override
  Map<String, dynamic> toMap(Predicate object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnSentenceId: object.sentenceId,
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

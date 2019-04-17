import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';

/// Database table for the Action class
class ActionDao implements Dao<Action> {
  /// Creates an Action database table object
  ActionDao();

  /// The name of the table
  final String tableName = 'action';

  /// id column name
  final String columnId = 'id';

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
  Action fromMap(Map<String, dynamic> query) => Action.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        predicateId: query[columnPredicateId] as int,
      );

  @override
  Map<String, dynamic> toMap(Action object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnPredicateId: object.predicateId,
      };

  @override
  List<Action> fromList(List<Map<String, dynamic>> query) {
    final List<Action> actions = <Action>[];
    for (final Map<String, dynamic> map in query) {
      actions.add(fromMap(map));
    }
    return actions;
  }
}

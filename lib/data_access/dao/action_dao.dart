import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/action.dart';

/// Database table for the Action class
class ActionDao implements Dao<ActionVerb>, ConceptDao {
  /// Creates an Action database table object
  ActionDao();

  @override
  String get tableName => 'action';

  @override
  String get tableNameTr => 'action_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'action_id';

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
  ActionVerb fromMap(Map<String, dynamic> query) => ActionVerb.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        predicateId: query[columnParentId] as int,
      );

  @override
  Map<String, dynamic> toMap(ActionVerb object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.predicateId,
      };

  @override
  List<ActionVerb> fromList(List<Map<String, dynamic>> query) {
    final List<ActionVerb> actions = <ActionVerb>[];
    for (final Map<String, dynamic> map in query) {
      actions.add(fromMap(map));
    }
    return actions;
  }
}

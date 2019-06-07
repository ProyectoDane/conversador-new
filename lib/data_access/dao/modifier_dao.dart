import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';

/// Database table for the Modifier class
class ModifierDao implements Dao<Modifier>, ConceptDao {
  /// Database table class constructor
  ModifierDao();

  @override
  String get tableName => 'modifier';

  @override
  String get tableNameTr => 'modifier_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'modifier_id';

  @override
  String get columnValue => 'value';

  @override
  String get columnParentId => 'subject_id';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnValue text not null,
      $columnParentId integer not null,
      FOREIGN KEY ($columnParentId) REFERENCES subject (id))
    ''';

  @override
  Modifier fromMap(Map<String, dynamic> query) => Modifier.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        subjectId: query[columnParentId] as int,
      );

  @override
  Map<String, dynamic> toMap(Modifier object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.subjectId,
      };

  @override
  List<Modifier> fromList(List<Map<String, dynamic>> query) {
    final List<Modifier> modifiers = <Modifier>[];
    for (final Map<String, dynamic> map in query) {
      modifiers.add(fromMap(map));
    }
    return modifiers;
  }
}

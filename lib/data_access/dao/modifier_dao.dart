import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/modifier.dart';

/// Database table for the Modifier class
class ModifierDao implements Dao<Modifier> {
  /// Database table class constructor
  ModifierDao();

  /// The name of the table
  final String tableName = 'modifier';

  /// The name of the translation table
  final String tableNameTr = 'modifier_tr';

  /// id column name
  final String columnId = 'id';

  /// untranslated table id column name
  final String columnIdSource = 'modifier_id';

  /// value column name
  final String columnValue = 'value';

  /// subject id column name
  final String columnSubjectId = 'subject_id';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnValue text not null,
      $columnSubjectId integer not null,
      FOREIGN KEY ($columnSubjectId) REFERENCES subject (id))
    ''';

  @override
  Modifier fromMap(Map<String, dynamic> query) => Modifier.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        subjectId: query[columnSubjectId] as int,
      );

  @override
  Map<String, dynamic> toMap(Modifier object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnSubjectId: object.subjectId,
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

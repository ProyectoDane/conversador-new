import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';

/// Database table for the Entity class
class EntityDao implements Dao<Entity> {
  /// Database table class constructor
  EntityDao();

  /// The name of the table
  final String tableName = 'entity';

  /// id column name
  final String columnId = 'id';

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
  Entity fromMap(Map<String, dynamic> query) => Entity.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        subjectId: query[columnSubjectId] as int,
      );

  @override
  Map<String, dynamic> toMap(Entity object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnSubjectId: object.subjectId,
      };

  @override
  List<Entity> fromList(List<Map<String, dynamic>> query) {
    final List<Entity> entities = <Entity>[];
    for (final Map<String, dynamic> map in query) {
      entities.add(fromMap(map));
    }
    return entities;
  }
}

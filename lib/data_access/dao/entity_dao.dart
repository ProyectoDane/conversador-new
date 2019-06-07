import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/entity.dart';

/// Database table for the Entity class
class EntityDao implements Dao<Entity>, ConceptDao {
  /// Database table class constructor
  EntityDao();

  @override
  String get tableName => 'entity';

  @override
  String get tableNameTr => 'entity_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'entity_id';

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
  Entity fromMap(Map<String, dynamic> query) => Entity.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        subjectId: query[columnParentId] as int,
      );

  @override
  Map<String, dynamic> toMap(Entity object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.subjectId,
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

import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';

/// Database table for the Subject class
class SubjectDao implements Dao<Subject>, ConceptDao {
  /// Database table class constructor
  SubjectDao();

  @override
  String get tableName => 'subject';

  @override
  String get tableNameTr => 'subject_tr';

  @override
  String get columnId => 'id';

  @override
  String get columnIdSource => 'subject_id';

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
  Subject fromMap(Map<String, dynamic> query) => Subject.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        sentenceId: query[columnParentId] as int,
      );

  @override
  Map<String, dynamic> toMap(Subject object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnParentId: object.sentenceId,
      };

  @override
  List<Subject> fromList(List<Map<String, dynamic>> query) {
    final List<Subject> subjects = <Subject>[];
    for (final Map<String, dynamic> map in query) {
      subjects.add(fromMap(map));
    }
    return subjects;
  }
}

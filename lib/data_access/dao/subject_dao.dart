import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/subject.dart';

/// Database table for the Subject class
class SubjectDao implements Dao<Subject> {
  /// Database table class constructor
  SubjectDao();

  /// The name of the table
  final String tableName = 'subject';

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
  Subject fromMap(Map<String, dynamic> query) => Subject.data(
        id: query[columnId] as int,
        value: query[columnValue] as String,
        sentenceId: query[columnSentenceId] as int,
      );

  @override
  Map<String, dynamic> toMap(Subject object) => <String, dynamic>{
        columnId: object.id,
        columnValue: object.value,
        columnSentenceId: object.sentenceId,
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

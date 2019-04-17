import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/concept/sentence.dart';

/// Database table for the Sentence class
class SentenceDao implements Dao<Sentence> {
  /// Database table class constructor
  SentenceDao();

  /// The name of the table
  final String tableName = 'sentence';

  /// id column name
  final String columnId = 'id';

  /// stage id column name
  final String columnStageId = 'stage_id';

  @override
  String get createTableQuery => '''
  CREATE TABLE IF NOT EXISTS $tableName ( 
    $columnId integer primary key, 
    $columnStageId integer not null, 
    FOREIGN KEY ($columnStageId) REFERENCES stage (id))
    ''';

// Try getSubjectConceptsBySentenceDepth
  @override
  Sentence fromMap(Map<String, dynamic> query) => Sentence.data(
        id: query[columnId] as int,
        stageId: query[columnStageId] as int,
      );

  @override
  Map<String, dynamic> toMap(Sentence object) => <String, dynamic>{
        columnId: object.id,
        columnStageId: object.stageId,
      };

  @override
  List<Sentence> fromList(List<Map<String, dynamic>> query) {
    final List<Sentence> sentences = <Sentence>[];
    for (final Map<String, dynamic> map in query) {
      sentences.add(fromMap(map));
    }
    return sentences;
  }
}

import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/stage/stage.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';

/// Database table for the Stage class
class StageDao implements Dao<Stage> {
  /// Database table class constructor
  StageDao();

  /// The name of the table
  final String tableName = 'stage';

  /// id column name
  final String columnId = 'id';

  /// mental complexity id column name
  final String columnMentalComplexityId = 'mental_complexity_id';

  /// background uri column name
  final String columnBackgroundUri = 'background_uri';

  @override
  String get createTableQuery => '''
  CREATE TABLE IF NOT EXISTS $tableName ( 
    $columnId integer primary key, 
    $columnBackgroundUri text not null,
    $columnMentalComplexityId integer not null,
    FOREIGN KEY ($columnMentalComplexityId) REFERENCES mental_complexity (id))
    ''';

  @override
  Stage fromMap(Map<String, dynamic> query) => Stage.data(
      id: query[columnId] as int,
      backgroundUri: query[columnBackgroundUri] as String,
      mentalComplexity: query[columnMentalComplexityId] as Complexity);

  @override
  Map<String, dynamic> toMap(Stage object) => <String, dynamic>{
        columnId: object.id,
        columnBackgroundUri: object.backgroundUri,
        columnMentalComplexityId: object.mentalComplexity
      };

  @override
  List<Stage> fromList(List<Map<String, dynamic>> query) {
    final List<Stage> stages = <Stage>[];
    for (final Map<String, dynamic> map in query) {
      stages.add(fromMap(map));
    }
    return stages;
  }
}

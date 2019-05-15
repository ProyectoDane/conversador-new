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
  final String columnComplexityId = 'mental_complexity_id';

  /// complexity order column name
  final String columnComplexityOrder = 'complexity_order_id';

  /// background uri column name
  final String columnBackgroundUri = 'background_uri';

  @override
  String get createTableQuery => '''
  CREATE TABLE IF NOT EXISTS $tableName ( 
    $columnId integer primary key, 
    $columnBackgroundUri text not null,
    $columnComplexityOrder integer not null,
    $columnComplexityId integer not null,
    FOREIGN KEY ($columnComplexityId) REFERENCES mental_complexity (id))
    ''';

  @override
  Stage fromMap(Map<String, dynamic> query) => Stage.data(
      id: query[columnId] as int,
      backgroundUri: query[columnBackgroundUri] as String,
      complexityOrder: query[columnComplexityOrder] as int,
      mentalComplexity: Complexity.values[query[columnComplexityId] as int]);

  @override
  Map<String, dynamic> toMap(Stage object) => <String, dynamic>{
        columnId: object.id,
        columnBackgroundUri: object.backgroundUri,
        columnComplexityId: object.mentalComplexity.index,
        columnComplexityOrder: object.complexityOrder
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

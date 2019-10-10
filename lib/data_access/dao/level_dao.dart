import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/stage/level.dart';
//import 'package:flutter_syntactic_sorter/model/stage/stage.dart';

/// Database table for the level class
class LevelDao implements Dao<Level> {
  /// The name of the table
  final String tableName = 'level';

  /// Id column name
  final String columnId = 'id';

  /// Stage count column name
  final String columnStageCount = 'stage_count';

  /// Is Stage random
  final String columnIsRandom = 'is_random';

  /// The name of the stage guide table
  final String tableNameSt = 'level_st';

  /// Level id in relation to stage
  final String columnLevelIdSt = 'level_id';

  /// Stage id related to level
  final String columnStageIdSt = 'stage_id';

  /// Key for stage list
  final String stageIdListKey = 'stage_id_list';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnStageCount integer not null,
      $columnIsRandom integer not null
    ''';

  @override
  Level fromMap(Map<String, dynamic> query) => Level(
    id: query[columnId] as int,
    stageCount: query[columnStageCount] as int,
    isRandom: query[columnIsRandom] as int == 1,
    stageIdsList: query[stageIdListKey] as List<int>
  );

  @override
  Map<String, dynamic> toMap(Level object) => <String, dynamic>{
        columnId: object.id,
        columnStageCount: object.stageCount,
        columnIsRandom: object.isRandom
      };

  @override
  List<Level> fromList(List<Map<String, dynamic>> query) {
    final List<Level> levels = <Level>[];
    for (final Map<String, dynamic> map in query) {
      levels.add(fromMap(map));
    }
    return levels;
  }
}
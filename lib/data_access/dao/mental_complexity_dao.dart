import 'package:flutter_syntactic_sorter/data_access/dao/dao.dart';
import 'package:flutter_syntactic_sorter/model/difficulty/mental_complexity.dart';

/// Database table for the MentalComplexity class
class MentalComplexityDao implements Dao<MentalComplexity> {
  /// Database table class constructor
  MentalComplexityDao();

  /// The name of the table
  final String tableName = 'mental_complexity';

  /// id column name
  final String columnId = 'id';

  /// description column name
  final String columnDescription = 'description';

  @override
  String get createTableQuery => '''
    CREATE TABLE IF NOT EXISTS $tableName ( 
      $columnId integer primary key, 
      $columnDescription text not null)
    ''';

  @override
  MentalComplexity fromMap(Map<String, dynamic> query) => MentalComplexity(
      id: query[columnId] as int,
      description: query[columnDescription] as String);

  @override
  Map<String, dynamic> toMap(MentalComplexity object) => <String, dynamic>{
        columnId: object.id,
        columnDescription: object.description
      };

  @override
  List<MentalComplexity> fromList(List<Map<String, dynamic>> query) {
    final List<MentalComplexity> difficulties = <MentalComplexity>[];
    for (final Map<String, dynamic> map in query) {
      difficulties.add(fromMap(map));
    }
    return difficulties;
  }
}

/// Helper class for preselecting stage before games starts
class StageSelection {
  /// Singleton declaration
  factory StageSelection() => _singleton;
  StageSelection._internal();
  static final StageSelection _singleton = StageSelection._internal();

  int _selectedStageId;
  /// Last stage id played in live stage
  int lastStagePlayed;

  /// Save stage selection data
  set stageSelection(int stageId) {
    _selectedStageId = stageId;
  }

  /// Return stage selection data
  int get stageSelection {
    final int aux = _selectedStageId;
    _selectedStageId = null;
    return aux;
  }
}
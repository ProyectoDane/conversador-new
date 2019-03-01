abstract class GameSettingsState {}

class InitialState extends GameSettingsState {}

class ErrorState extends GameSettingsState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

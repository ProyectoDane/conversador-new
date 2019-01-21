abstract class MainState {}

class InitialState extends MainState {}

class ErrorState extends MainState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

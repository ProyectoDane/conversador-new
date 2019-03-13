import 'package:meta/meta.dart';

class Operator {
  static const String SUCCESSFUL_SOUND = 'sounds/successful.mp3';
  static const String FAILURE_SOUND = 'sounds/failure.mp3';

  final String sound;
  final Function newState;

  Operator({@required this.sound, @required this.newState});

  factory Operator.success({@required final newState}) => Operator(sound: SUCCESSFUL_SOUND, newState: newState);

  factory Operator.failure({@required final newState}) =>
      Operator(sound: FAILURE_SOUND, newState: newState);
}

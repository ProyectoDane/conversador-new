import 'package:meta/meta.dart';

/// Class to encapsulate reactions to events,
/// in particular, sounds and changes to the state.
class Operator {

  Operator._internal({@required this.sound, 
                      @required this.volume, 
                      @required this.newState});

  /// A Success event, with a winner sound and the given state mutation
  factory Operator.success({@required final void Function() newState}) =>
      Operator._internal(
        sound: _SUCCESSFUL_SOUND, volume: 0.15, newState: newState);

  /// A Failure event, with a sad sound and the given state mutation
  factory Operator.failure({@required final void Function() newState}) =>
      Operator._internal(
        sound: _FAILURE_SOUND, volume: 1, newState: newState);

  static const String _SUCCESSFUL_SOUND = 'sounds/successful.mp3';
  static const String _FAILURE_SOUND = 'sounds/failure.mp3';

  /// The corresponding sound
  final String sound;
  /// The corresponding volume
  final double volume;
  /// The function to call for changing state after event
  final void Function() newState;

}

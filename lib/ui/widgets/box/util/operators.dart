import 'package:meta/meta.dart';

class Operator {
  static const String SUCCESSFUL_SOUND = 'sounds/successful.mp3';
  static const String FAILURE_SOUND = 'sounds/failure.mp3';

  final String sound;
  final Function action;
  final bool shouldNotifyFailure;

  Operator({@required this.sound, @required this.action, this.shouldNotifyFailure = false});

  factory Operator.success(action) => Operator(sound: SUCCESSFUL_SOUND, action: action);

  factory Operator.failure(action) => Operator(sound: FAILURE_SOUND, action: action, shouldNotifyFailure: true);
}

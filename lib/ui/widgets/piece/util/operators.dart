import 'package:meta/meta.dart';

/// Class to encapsulate reactions to events,
/// in particular, sounds and changes to the state.
class Operator {

  Operator._internal({ @required this.newState});

  /// A Success event, with a winner sound and the given state mutation
  factory Operator.success({@required final void Function() newState}) =>
      Operator._internal(newState: newState);

  /// A Failure event, with a sad sound and the given state mutation
  factory Operator.failure({@required final void Function() newState}) =>
      Operator._internal(newState: newState);

  /// The function to call for changing state after event
  final void Function() newState;

}

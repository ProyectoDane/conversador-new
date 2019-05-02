/// Easy
const int mentalComplexityEasy = 1;
/// Normal
const int mentalComplexityNormal = 2;
/// Hard
const int mentalComplexityHard = 3;
/// Expert
const int mentalComplexityExpert = 4;
/// Map for complexity strings
const Map<int,String> textMap = <int,String>{
  mentalComplexityEasy: 'Easy',
  mentalComplexityNormal: 'Normal',
  mentalComplexityHard: 'Hard',
  mentalComplexityExpert: 'Expert'
  };

/// Mental complexity of the stage the user
/// will try to resolve
class MentalComplexity {
  /// Creates a MentalComplexity with a name.
  MentalComplexity({this.id, this.description});

  /// Id of the mental complexity
  int id;

  /// Description of the mental complexity
  String description;
}

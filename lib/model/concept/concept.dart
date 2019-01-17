import 'package:flutter/material.dart';

abstract class Concept {
  final String value;
  final int id;

  Concept({@required this.value, @required this.id});
}

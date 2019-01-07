import 'package:flutter/material.dart';
import 'package:flutter_syntactic_sorter/model/shape.dart';

class Word {
  final int id;
  final String value;
  final Shape shape;

  Word({@required this.id, @required this.value, @required this.shape});
}

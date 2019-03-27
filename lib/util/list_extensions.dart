import 'dart:math';

import 'package:tuple/tuple.dart';

List<E> shuffled<E>(List<E> list) =>
  List<E>.from(list)..shuffle();

List<Tuple2<int, E>> enumerated<E>(List<E> list) {
  final List<Tuple2<int, E>> enumeratedList = <Tuple2<int, E>>[];
  for (int i = 0; i < list.length; i++) {
    enumeratedList.add(Tuple2<int, E>(i, list[i]));
  }
  return enumeratedList;
}

R reduce<E, R>(
    List<E> list,
    R initialValue,
    R Function(R acum, E element) combine
) {
  R result = initialValue;
  for (final E element in list) {
    result = combine(result, element);
  }
  return result;
}

List<Tuple2<A,B>> zip<A,B>(List<A> first, List<B> second) {
  final int lastIndex = min(first.length, second.length);
  final List<Tuple2<A,B>> result = <Tuple2<A,B>>[];
  for (int i = 0; i < lastIndex; i++) {
    result.add(Tuple2<A,B>(first[i], second[i]));
  }
  return result;
}
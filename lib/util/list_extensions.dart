import 'dart:math';

import 'package:tuple/tuple.dart';

/// Returns a new list with the same given values but shuffled
List<E> shuffled<E>(List<E> list) => List<E>.from(list)..shuffle();

/// Returns a new list of tuples that contain the
/// number of each element and the element itself
List<Tuple2<int, E>> enumerated<E>(List<E> list) {
  final List<Tuple2<int, E>> enumeratedList = <Tuple2<int, E>>[];
  for (int i = 0; i < list.length; i++) {
    enumeratedList.add(Tuple2<int, E>(i, list[i]));
  }
  return enumeratedList;
}

/// Returns an R value as the result of starting with initialValue
/// and replacing it for the result of calling combine with it
/// and each element of the given list sequentially
R reduce<E, R>(
    List<E> list, R initialValue, R Function(R acum, E element) combine) {
  R result = initialValue;
  for (final E element in list) {
    result = combine(result, element);
  }
  return result;
}

/// Returns a new list that pairs up the elements in the given lists,
/// respecting their order and ending when reaching the end of either of them
List<Tuple2<A, B>> zip<A, B>(List<A> first, List<B> second) {
  final int lastIndex = min(first.length, second.length);
  final List<Tuple2<A, B>> result = <Tuple2<A, B>>[];
  for (int i = 0; i < lastIndex; i++) {
    result.add(Tuple2<A, B>(first[i], second[i]));
  }
  return result;
}

/// Randomly selects a sample of quantityOfSamples size from the given list
List<E> sampleDownTo<E>(List<E> list, int quantityOfSamples) {
  final List<E> copy = List<E>.of(list);
  final List<E> sample = <E>[];
  for (int i = 0; i < quantityOfSamples; i++) {
    final int randomIndex = Random().nextInt(copy.length);
    sample.add(copy[randomIndex]);
    copy.removeAt(randomIndex);
  }
  return sample;
}

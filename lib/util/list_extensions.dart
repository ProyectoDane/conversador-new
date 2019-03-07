import 'package:tuple/tuple.dart';

List<E> shuffled<E>(List<E> list) {
  final listCopy = List<E>.from(list);
  listCopy.shuffle();
  return listCopy;//listCopy;
}

List<Tuple2<int, E>> enumerated<E>(List<E> list) {
  List<Tuple2<int, E>> enumeratedList = List();
  for (var i = 0; i < list.length; i++) {
    enumeratedList.add(Tuple2(i, list[i]));
  }
  return enumeratedList;
}

R reduce<E, R>(List<E> list, R initialValue, R combine(R acum, E element)) {
  var result = initialValue;
  for (var element in list) {
    result = combine(result, element);
  }
  return result;
}
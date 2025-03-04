import 'package:equatable/equatable.dart';

class Cursor<T> extends Equatable {
  const Cursor({required this.element, required this.index, required this.total});

  final T? element;
  final int index;
  final int total;

  bool get allQuestionsAreAnswered => element == null;

  @override
  List<Object?> get props => [element, index, total];
}

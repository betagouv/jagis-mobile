import 'package:equatable/equatable.dart';

class Cursor<T> extends Equatable {
  const Cursor({required this.current, required this.index, required this.total});

  final T? current;
  final int index;
  final int total;

  bool get allQuestionsAreAnswered => current == null;

  @override
  List<Object?> get props => [current, index, total];
}

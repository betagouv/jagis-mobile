import 'package:equatable/equatable.dart';

class Cursor<T> extends Equatable {
  const Cursor({required this.elements, required final int index}) : index = index < 0 ? 0 : index;

  final List<T> elements;
  final int index;

  bool get isEnd => this.index >= this.elements.length;
  bool get isStart => this.index <= 0;

  T? get element =>
      this.elements.isEmpty || isEnd
          ? null
          : isStart
          ? this.elements.first
          : this.elements[this.index];

  int get total => this.elements.length;

  @override
  List<Object?> get props => [elements, index, total];
}

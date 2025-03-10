import 'package:equatable/equatable.dart';

class Cursor<T> extends Equatable {
  const Cursor({required this.elements, required this.index});

  final List<T> elements;
  final int index;

  T? get element =>
      this.elements.isEmpty || this.index >= this.elements.length
          ? null
          : this.index < 0
          ? this.elements.first
          : this.elements[this.index];

  int get total => this.elements.length;

  @override
  List<Object?> get props => [elements, index, total];
}

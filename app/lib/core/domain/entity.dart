import 'package:equatable/equatable.dart';

abstract class Entity<T extends Object> extends Equatable {
  const Entity({required this.code});

  final T code;

  @override
  List<Object> get props => [code];
}

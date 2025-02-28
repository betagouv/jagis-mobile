import 'package:equatable/equatable.dart';

class ActionFilter extends Equatable {
  const ActionFilter({required this.code, required this.label, required this.selected});

  final String code;
  final String label;
  final bool selected;

  @override
  List<Object?> get props => [code, label, selected];
}

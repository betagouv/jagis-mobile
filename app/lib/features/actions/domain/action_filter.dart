import 'package:equatable/equatable.dart';

class ActionFilter extends Equatable {
  const ActionFilter({required this.code, required this.titre, required this.choisi});

  final String code;
  final String titre;
  final bool choisi;

  @override
  List<Object?> get props => [code, titre, choisi];
}

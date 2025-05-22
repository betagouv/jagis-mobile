import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuestionCodePostalState extends Equatable {
  const QuestionCodePostalState({
    required this.pseudonym,
    required this.codePostal,
    required this.communes,
    required this.commune,
    required this.aEteChange,
  });

  final String pseudonym;
  final String codePostal;
  final List<String> communes;
  final String commune;
  final bool aEteChange;
  bool get estRempli => codePostal.isNotEmpty && commune.isNotEmpty;

  QuestionCodePostalState copyWith({
    final String? pseudonym,
    final String? codePostal,
    final List<String>? communes,
    final String? commune,
    final bool? aEteChange,
  }) => QuestionCodePostalState(
    pseudonym: pseudonym ?? this.pseudonym,
    codePostal: codePostal ?? this.codePostal,
    communes: communes ?? this.communes,
    commune: commune ?? this.commune,
    aEteChange: aEteChange ?? this.aEteChange,
  );

  @override
  List<Object> get props => [pseudonym, codePostal, communes, commune, aEteChange];
}

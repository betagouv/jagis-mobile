import 'package:app/features/communes/municipality.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuestionCodePostalState extends Equatable {
  const QuestionCodePostalState({
    required this.pseudonym,
    required this.codePostal,
    required this.communes,
    required this.codeInsee,
    required this.aEteChange,
  });

  final String pseudonym;
  final String codePostal;
  final List<Municipality> communes;
  final String codeInsee;
  final bool aEteChange;
  bool get estRempli => codePostal.isNotEmpty && codeInsee.isNotEmpty;

  QuestionCodePostalState copyWith({
    final String? pseudonym,
    final String? codePostal,
    final List<Municipality>? communes,
    final String? codeInsee,
    final bool? aEteChange,
  }) => QuestionCodePostalState(
    pseudonym: pseudonym ?? this.pseudonym,
    codePostal: codePostal ?? this.codePostal,
    communes: communes ?? this.communes,
    codeInsee: codeInsee ?? this.codeInsee,
    aEteChange: aEteChange ?? this.aEteChange,
  );

  @override
  List<Object> get props => [pseudonym, codePostal, communes, codeInsee, aEteChange, codeInsee];
}

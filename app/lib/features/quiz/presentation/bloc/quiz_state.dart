import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
final class QuizState extends Equatable {
  const QuizState({required this.quiz, required this.reponse, required this.estExacte});

  const QuizState.empty()
    : this(
        quiz: const Quiz(
          id: '',
          thematique: '',
          question: '',
          responses: [],
          points: 0,
          explicationOk: '',
          explicationKo: '',
          article: null,
          sources: [],
        ),
        reponse: const None(),
        estExacte: const None(),
      );

  final Quiz quiz;
  final Option<String> reponse;
  bool get estSelectionnee => reponse.isSome();
  final Option<bool> estExacte;

  String get explication =>
      estExacte.fold(() => '', (final estExacte) => quiz.article ?? (estExacte ? quiz.explicationOk : quiz.explicationKo) ?? '');

  QuizState copyWith({final Quiz? quiz, final Option<String>? reponse, final Option<bool>? estExacte}) =>
      QuizState(quiz: quiz ?? this.quiz, reponse: reponse ?? this.reponse, estExacte: estExacte ?? this.estExacte);

  @override
  List<Object?> get props => [quiz, reponse, estExacte];
}

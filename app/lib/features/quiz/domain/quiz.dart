import 'package:app/core/source/source.dart';
import 'package:equatable/equatable.dart';

final class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.thematique,
    required this.question,
    required this.responses,
    required this.points,
    required this.explicationOk,
    required this.explicationKo,
    required this.article,
    required this.sources,
  });

  final String id;
  final String thematique;
  final String question;
  final List<QuizResponse> responses;
  final int points;
  final String? explicationOk;
  final String? explicationKo;
  final String? article;
  final List<Source> sources;

  @override
  List<Object?> get props => [id, thematique, question, responses, points, explicationOk, explicationKo, article, sources];
}

final class QuizResponse extends Equatable {
  const QuizResponse({required this.response, required this.exact});

  final String response;
  final bool exact;

  @override
  List<Object> get props => [response, exact];
}

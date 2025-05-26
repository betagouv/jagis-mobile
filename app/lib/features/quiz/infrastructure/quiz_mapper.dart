// ignore_for_file: avoid_dynamic_calls

import 'package:app/core/source/source_mapper.dart';
import 'package:app/features/quiz/domain/quiz.dart';

abstract final class QuizMapper {
  const QuizMapper._();

  static Quiz fromJson(final Map<String, dynamic> json) {
    final question = json['questions'][0] as Map<String, dynamic>;

    return Quiz(
      id: json['content_id'] as String,
      thematique: json['thematique_principale'] as String,
      question: question['libelle'] as String,
      responses: (question['reponses'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((final e) => QuizResponse(response: e['reponse'] as String, exact: e['exact'] as bool? ?? false))
          .toList(),
      points: json['points'] as int,
      explicationOk: question['explicationOk'] as String?,
      explicationKo: question['explicationKO'] as String?,
      article: json['article_contenu'] as String?,
      sources: json['article_sources'] == null
          ? []
          : (json['article_sources'] as List<dynamic>).cast<Map<String, dynamic>>().map(SourceMapper.fromJson).toList(),
    );
  }
}

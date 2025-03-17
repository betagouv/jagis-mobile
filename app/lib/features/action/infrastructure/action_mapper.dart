import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_service_mapper.dart';
import 'package:app/features/aids/core/infrastructure/aid_summary_mapper.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';

abstract final class ActionClassicMapper {
  const ActionClassicMapper._();

  static ActionClassic fromJson(final Map<String, dynamic> json) => ActionClassic(
    id: json['code'] as String,
    title: json['titre'] as String,
    subTitle: json['sous_titre'] as String?,
    alreadySeen: json['deja_vue'] as bool,
    isDone: json['deja_faite'] as bool,
    aidSummaries: (json['aides'] as List<dynamic>).cast<Map<String, dynamic>>().map(AidSummaryMapper.fromJson).toList(),
    why: json['pourquoi'] as String,
    how: json['comment'] as String,
    services: (json['services'] as List<dynamic>).cast<Map<String, dynamic>>().map(ActionServiceMapper.fromJson).toList(),
  );
}

abstract final class ActionQuizMapper {
  const ActionQuizMapper._();

  static ActionQuiz fromJson(final Map<String, dynamic> json) => ActionQuiz(
    id: json['code'] as String,
    title: json['titre'] as String,
    subTitle: json['sous_titre'] as String?,
    alreadySeen: json['deja_vue'] as bool,
    isDone: json['deja_faite'] as bool,
    aidSummaries: (json['aides'] as List<dynamic>).cast<Map<String, dynamic>>().map(AidSummaryMapper.fromJson).toList(),
    quizzes: (json['quizzes'] as List<dynamic>).cast<Map<String, dynamic>>().map(QuizMapper.fromJson).toList(),
    congratulatoryText: json['quizz_felicitations'] as String,
  );
}

abstract final class ActionSimulatorMapper {
  const ActionSimulatorMapper._();

  static ActionSimulator fromJson(final Map<String, dynamic> json) => ActionSimulator(
    id: json['code'] as String,
    title: json['titre'] as String,
    subTitle: json['sous_titre'] as String?,
    alreadySeen: json['deja_vue'] as bool,
    isDone: json['deja_faite'] as bool,
    aidSummaries: (json['aides'] as List<dynamic>).cast<Map<String, dynamic>>().map(AidSummaryMapper.fromJson).toList(),
    why: json['pourquoi'] as String,
    questions:
        (json['kycs'] as List<dynamic>).cast<Map<String, dynamic>>().map(QuestionMapper.fromJson).whereType<Question>().toList(),
  );
}

import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_service_mapper.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/infrastructure/aid_summary_mapper.dart';
import 'package:app/features/faq/domain/faq.dart';
import 'package:app/features/faq/infrastructure/faq_mapper.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/quiz/infrastructure/quiz_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class ActionMapper {
  const ActionMapper._();

  static ThemeType themeTypeFromJson(final Map<String, dynamic> json) => ThemeTypeMapper.convert(json['thematique'] as String);
  static String idFromJson(final Map<String, dynamic> json) => json['code'] as String;
  static String titleFromJson(final Map<String, dynamic> json) => json['titre'] as String;
  static String? subTitleFromJson(final Map<String, dynamic> json) => json['sous_titre'] as String?;
  static bool alreadySeenFromJson(final Map<String, dynamic> json) => json['deja_vue'] as bool;
  static bool isDoneFromJson(final Map<String, dynamic> json) => json['deja_faite'] as bool;
  static int nbActionsDoneFromJson(final Map<String, dynamic> json) => json['nombre_actions_faites'] as int;
  static int scoreFromJson(final Map<String, dynamic> json) => json['points'] as int;
  static List<AidSummary> aidSummariesFromJson(final Map<String, dynamic> json) =>
      JsonListMapper.fromJsonList(json['aides'], AidSummaryMapper.fromJson);
  static List<FAQItem>? faqFromJson(final Map<String, dynamic> json) =>
      json['faqs'] == null ? null : JsonListMapper.fromJsonList(json['faqs'], FAQItemMapper.fromJson);
}

abstract final class ActionClassicMapper {
  const ActionClassicMapper._();

  static ActionClassic fromJson(final Map<String, dynamic> json) => ActionClassic(
    themeType: ActionMapper.themeTypeFromJson(json),
    id: ActionMapper.idFromJson(json),
    title: ActionMapper.titleFromJson(json),
    subTitle: ActionMapper.subTitleFromJson(json),
    alreadySeen: ActionMapper.alreadySeenFromJson(json),
    isDone: ActionMapper.isDoneFromJson(json),
    aidSummaries: ActionMapper.aidSummariesFromJson(json),
    nbActionsDone: ActionMapper.nbActionsDoneFromJson(json),
    score: ActionMapper.scoreFromJson(json),
    faq: ActionMapper.faqFromJson(json),
    why: json['pourquoi'] as String,
    instruction: json['consigne'] as String,
    scoreLabel: json['label_compteur'] as String,
    how: json['comment'] as String,
    services: JsonListMapper.fromJsonList(json['services'], ActionServiceMapper.fromJson),
  );
}

abstract final class ActionQuizMapper {
  const ActionQuizMapper._();

  static ActionQuiz fromJson(final Map<String, dynamic> json) => ActionQuiz(
    themeType: ActionMapper.themeTypeFromJson(json),
    id: ActionMapper.idFromJson(json),
    title: ActionMapper.titleFromJson(json),
    subTitle: ActionMapper.subTitleFromJson(json),
    alreadySeen: ActionMapper.alreadySeenFromJson(json),
    isDone: ActionMapper.isDoneFromJson(json),
    aidSummaries: ActionMapper.aidSummariesFromJson(json),
    nbActionsDone: ActionMapper.nbActionsDoneFromJson(json),
    score: ActionMapper.scoreFromJson(json),
    faq: ActionMapper.faqFromJson(json),
    quizzes: JsonListMapper.fromJsonList(json['quizzes'], QuizMapper.fromJson),
    congratulatoryText: json['quizz_felicitations'] as String,
  );
}

abstract final class ActionSimulatorMapper {
  const ActionSimulatorMapper._();

  static ActionSimulator fromJson(final Map<String, dynamic> json) => ActionSimulator(
    themeType: ActionMapper.themeTypeFromJson(json),
    id: ActionMapper.idFromJson(json),
    title: ActionMapper.titleFromJson(json),
    subTitle: ActionMapper.subTitleFromJson(json),
    alreadySeen: ActionMapper.alreadySeenFromJson(json),
    isDone: ActionMapper.isDoneFromJson(json),
    aidSummaries: ActionMapper.aidSummariesFromJson(json),
    nbActionsDone: ActionMapper.nbActionsDoneFromJson(json),
    score: ActionMapper.scoreFromJson(json),
    faq: ActionMapper.faqFromJson(json),
    why: json['pourquoi'] as String,
    questions: JsonListMapper.fromJsonList(json['kycs'], QuestionMapper.fromJson),
  );
}

abstract final class ActionPerformanceMapper {
  const ActionPerformanceMapper._();

  static ActionPerformance fromJson(final Map<String, dynamic> json) => ActionPerformance(
    themeType: ActionMapper.themeTypeFromJson(json),
    id: ActionMapper.idFromJson(json),
    title: ActionMapper.titleFromJson(json),
    subTitle: ActionMapper.subTitleFromJson(json),
    alreadySeen: ActionMapper.alreadySeenFromJson(json),
    isDone: ActionMapper.isDoneFromJson(json),
    aidSummaries: ActionMapper.aidSummariesFromJson(json),
    nbActionsDone: ActionMapper.nbActionsDoneFromJson(json),
    score: ActionMapper.scoreFromJson(json),
    faq: ActionMapper.faqFromJson(json),
    questions: JsonListMapper.fromJsonList(json['kycs'], QuestionMapper.fromJson),
  );
}

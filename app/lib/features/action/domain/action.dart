import 'package:app/features/action/domain/action_service.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/faq/domain/faq.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

sealed class Action extends Equatable {
  const Action({
    required this.themeType,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.nbActionsDone,
    required this.alreadySeen,
    required this.isDone,
    required this.aidSummaries,
    required this.score,
    required this.faq,
  });

  final ThemeType themeType;
  final String id;
  final String title;
  final String? subTitle;
  final List<AidSummary> aidSummaries;
  final bool alreadySeen;
  final bool isDone;
  final int nbActionsDone;
  final int score;
  final List<FAQItem>? faq;

  String get instruction;
  String get instructionWhenDone;
  ActionType get type;

  @override
  List<Object?> get props => [themeType, id, title, subTitle, aidSummaries, alreadySeen, isDone, nbActionsDone, score, faq];
}

final class ActionClassic extends Action {
  const ActionClassic({
    required super.themeType,
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required super.nbActionsDone,
    required super.score,
    required super.faq,
    required this.why,
    required this.instruction,
    required this.scoreLabel,
    required this.how,
    required this.services,
  });

  final String why;
  final String how;
  final List<ActionService> services;
  final String scoreLabel;

  @override
  final String instruction;

  @override
  String get instructionWhenDone => 'Vous avez réalisez cette action';

  @override
  ActionType get type => ActionType.classic;

  ActionService get lvaoService => services.firstWhere((final service) => service.id == ServiceId.lvao);
  bool get hasLvaoService => services.any((final service) => service.id == ServiceId.lvao);
  ActionService get recipesService => services.firstWhere((final service) => service.id == ServiceId.recipes);
  bool get hasRecipesService => services.any((final service) => service.id == ServiceId.recipes);

  @override
  List<Object?> get props => [...super.props, how, services, scoreLabel, instruction, why];
}

final class ActionQuiz extends Action {
  const ActionQuiz({
    required super.themeType,
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required super.nbActionsDone,
    required super.score,
    required super.faq,
    required this.quizzes,
    required this.congratulatoryText,
  });

  final List<Quiz> quizzes;
  final String congratulatoryText;

  /// Le nombre de bonnes réponses requises pour valider l'action.
  ///
  /// On est partie sur une base de 6 questions par quiz, et 4 bonnes réponses.
  int get correctAnswersRequired => (quizzes.length * 4 / 6).ceil();

  @override
  List<Object?> get props => [...super.props, quizzes, congratulatoryText];

  @override
  String get instruction => 'Obtenez plus de $correctAnswersRequired bonnes réponses';

  @override
  String get instructionWhenDone => 'Vous avez obtenu plus de $correctAnswersRequired bonnes réponses';

  @override
  ActionType get type => ActionType.quiz;
}

final class ActionPerformance extends Action {
  const ActionPerformance({
    required super.themeType,
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.nbActionsDone,
    required super.aidSummaries,
    required super.score,
    required super.faq,
    required this.questions,
  });

  final List<Question> questions;

  @override
  List<Object?> get props => [...super.props, questions];

  @override
  String get instruction => 'Terminez ce bilan et gagnez';

  @override
  String get instructionWhenDone => 'Vous avez terminé ce bilan';

  @override
  ActionType get type => ActionType.performance;
}

final class ActionSimulator extends ActionPerformance {
  const ActionSimulator({
    required super.themeType,
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.faq,
    required super.nbActionsDone,
    required super.aidSummaries,
    required super.score,
    required super.questions,
    required this.why,
  });

  final String? why;

  @override
  List<Object?> get props => [...super.props, why, questions];

  ActionSimulatorId getId() => ActionSimulatorId.fromApiString(id);

  @override
  String get instruction => 'Terminez ce simulateur et gagnez';

  @override
  String get instructionWhenDone => 'Vous avez terminé ce simulateur';

  @override
  ActionType get type => ActionType.simulator;
}

enum ActionSimulatorId {
  carSimulator('action_simulateur_voiture'),
  mesAidesReno('simu_aides_reno');

  const ActionSimulatorId(this.apiString);
  final String apiString;

  static ActionSimulatorId fromApiString(final String id) => values.firstWhere(
    (final element) => element.apiString == id,
    orElse: () => throw UnimplementedError('Unknown simulator id: $id'),
  );
}

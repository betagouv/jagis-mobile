import 'package:app/features/action/domain/action_service.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';

sealed class Action extends Equatable {
  const Action({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.nbActionsDone,
    required this.alreadySeen,
    required this.isDone,
    required this.aidSummaries,
    required this.score,
  });

  final String id;
  final String title;
  final String? subTitle;
  final List<AidSummary> aidSummaries;
  final bool alreadySeen;
  final bool isDone;
  final int nbActionsDone;
  final int score;

  @override
  List<Object?> get props => [id, title, subTitle, alreadySeen, aidSummaries, isDone, nbActionsDone, score];

  String get instruction;
  String get instructionWhenDone;
  String get scoreLabel;
  ActionType get type;
}

final class ActionClassic extends Action {
  const ActionClassic({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required super.nbActionsDone,
    required super.score,
    required this.why,
    required this.instruction,
    required this.scoreLabel,
    required this.how,
    required this.services,
  });

  final String why;
  final String how;
  final List<ActionService> services;

  @override
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
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required super.nbActionsDone,
    required super.score,
    required this.quizzes,
    required this.congratulatoryText,
  });

  final List<Quiz> quizzes;
  final String congratulatoryText;

  @override
  List<Object?> get props => [...super.props, quizzes, congratulatoryText];

  @override
  String get instruction => 'Répondez à suffisamment de bonnes réponses pour gagner';

  @override
  String get instructionWhenDone => 'Vous avez terminé ce quiz';

  @override
  String get scoreLabel => 'quiz';

  @override
  ActionType get type => ActionType.quiz;
}

final class ActionSimulator extends Action {
  const ActionSimulator({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required this.why,
    required super.nbActionsDone,
    required super.aidSummaries,
    required super.score,
    required this.questions,
  });

  final String? why;
  final List<Question> questions;

  @override
  List<Object?> get props => [...super.props, why, questions];

  ActionSimulatorId getId() => switch (id) {
    'action_simulateur_voiture' => ActionSimulatorId.carSimulator,
    _ => throw UnimplementedError(),
  };

  @override
  String get instruction => 'Terminez ce simulateur et gagnez';

  @override
  String get instructionWhenDone => 'Vous avez terminé ce simulateur';

  @override
  String get scoreLabel => 'simulations';

  @override
  ActionType get type => ActionType.simulator;
}

enum ActionSimulatorId { carSimulator }

String actionSimulatorIdToAPIString(final ActionSimulatorId id) => switch (id) {
  ActionSimulatorId.carSimulator => 'action_simulateur_voiture',
};

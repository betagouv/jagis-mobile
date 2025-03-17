import 'package:app/features/action/domain/action_service.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';

sealed class Action extends Equatable {
  const Action({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.aidSummaries,
    required this.alreadySeen,
    required this.isDone,
  });

  final String id;
  final String title;
  final String? subTitle;
  final List<AidSummary> aidSummaries;
  final bool alreadySeen;
  final bool isDone;

  @override
  List<Object?> get props => [id, title, subTitle, aidSummaries, alreadySeen, isDone];
}

final class ActionClassic extends Action {
  const ActionClassic({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required this.why,
    required this.how,
    required this.services,
  });

  final String why;
  final String how;
  final List<ActionService> services;

  ActionService get lvaoService => services.firstWhere((final service) => service.id == ServiceId.lvao);
  bool get hasLvaoService => services.any((final service) => service.id == ServiceId.lvao);
  ActionService get recipesService => services.firstWhere((final service) => service.id == ServiceId.recipes);
  bool get hasRecipesService => services.any((final service) => service.id == ServiceId.recipes);

  @override
  List<Object?> get props => [...super.props, why, how, services];
}

final class ActionQuiz extends Action {
  const ActionQuiz({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required this.quizzes,
    required this.congratulatoryText,
  });

  final List<Quiz> quizzes;
  final String congratulatoryText;

  @override
  List<Object?> get props => [...super.props, quizzes, congratulatoryText];
}

final class ActionSimulator extends Action {
  const ActionSimulator({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.aidSummaries,
    required this.why,
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
}

enum ActionSimulatorId { carSimulator }

String actionSimulatorIdToAPIString(final ActionSimulatorId id) => switch (id) {
  ActionSimulatorId.carSimulator => 'action_simulateur_voiture',
};

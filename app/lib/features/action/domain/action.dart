import 'package:app/features/action/domain/action_service.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class Action extends Equatable {
  const Action({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.why,
    required this.nbActionsDone,
    required this.alreadySeen,
    required this.isDone,
    required this.aidSummaries,
    required this.score,
  });

  final String id;
  final String title;
  final String? subTitle;
  final String why;
  final int nbActionsDone;
  final int score;
  final bool alreadySeen;
  final bool isDone;
  final List<AidSummary> aidSummaries;

  @override
  List<Object?> get props => [id, title, subTitle, why, alreadySeen, aidSummaries, isDone];

  String get instruction;
  String get scoreLabel;
}

final class ActionClassic extends Action {
  const ActionClassic({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.why,
    required super.aidSummaries,
    required super.nbActionsDone,
    required super.score,
    required this.instruction,
    required this.scoreLabel,
    required this.how,
    required this.services,
  });

  final String how;
  final List<ActionService> services;

  @override
  final String scoreLabel;

  @override
  final String instruction;

  ActionService get lvaoService => services.firstWhere((final service) => service.id == ServiceId.lvao);
  bool get hasLvaoService => services.any((final service) => service.id == ServiceId.lvao);
  ActionService get recipesService => services.firstWhere((final service) => service.id == ServiceId.recipes);
  bool get hasRecipesService => services.any((final service) => service.id == ServiceId.recipes);

  @override
  List<Object?> get props => [...super.props, how, services];
}

final class ActionSimulator extends Action {
  const ActionSimulator({
    required super.id,
    required super.title,
    required super.subTitle,
    required super.alreadySeen,
    required super.isDone,
    required super.why,
    required super.nbActionsDone,
    required super.aidSummaries,
    required super.score,
    required this.questions,
  });

  final List<Question> questions;

  @override
  List<Object?> get props => [...super.props, questions];

  ActionSimulatorId getId() => switch (id) {
    'action_simulateur_voiture' => ActionSimulatorId.carSimulator,
    _ => throw UnimplementedError(),
  };

  @override
  String get instruction => 'Terminez ce simulateur et gagnez';

  @override
  String get scoreLabel => 'simulations';
}

enum ActionSimulatorId { carSimulator }

String actionSimulatorIdToAPIString(final ActionSimulatorId id) => switch (id) {
  ActionSimulatorId.carSimulator => 'action_simulateur_voiture',
};

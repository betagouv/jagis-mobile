import 'package:app/features/action/domain/action.dart';
import 'package:app/features/car_simulator/presentation/widgets/car_simulator_widget.dart';
import 'package:flutter/material.dart';

class ActionSimulatorView extends StatelessWidget {
  const ActionSimulatorView({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final context) => switch (action.getId()) {
    ActionSimulatorId.carSimulator => CarSimulatorWidget(isDone: action.isDone),
  };
}

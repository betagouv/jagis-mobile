import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/widgets/action_why_section_view.dart';
import 'package:app/features/car_simulator/presentation/widgets/car_simulator_widget.dart';
import 'package:flutter/material.dart';

class ActionSimulatorView extends StatelessWidget {
  const ActionSimulatorView({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final context) => Column(
    children: [
      if (action.why != null) ActionWhySectionView(why: action.why!),
      switch (action.getId()) {
        ActionSimulatorId.carSimulator => CarSimulatorWidget(isDone: action.isDone),
      },
    ],
  );
}

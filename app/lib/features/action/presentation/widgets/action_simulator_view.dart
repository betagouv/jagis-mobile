import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/widgets/action_why_section_view.dart';
import 'package:app/features/car_simulator/presentation/widgets/car_simulator_widget.dart';
import 'package:app/features/mes_aides_reno/presentation/mes_aides_reno_widget.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionSimulatorView extends StatelessWidget {
  const ActionSimulatorView({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s4w,
    children: [
      if (action.why != null) ActionWhySectionView(why: action.why!),
      switch (action.getId()) {
        ActionSimulatorId.carSimulator => CarSimulatorWidget(isDone: action.isDone),
        ActionSimulatorId.mesAidesReno => const MesAidesRenoWidget(),
      },
    ],
  );
}

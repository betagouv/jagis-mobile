import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/widgets/action_why_section_view.dart';
import 'package:app/features/car_simulator/presentation/widgets/car_simulator_widget.dart';
import 'package:app/features/mes_aides_reno/presentation/mes_aides_reno_widget.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_widget.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionSimulatorView extends StatelessWidget {
  const ActionSimulatorView({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s4w,
    children: [
      if (action.why != null) ActionWhySectionView(why: action.why!),
      switch (action.getId()) {
        ActionSimulatorId.carSimulator => CarSimulatorWidget(sequenceId: action.sequenceId, isDone: action.isDone),
        ActionSimulatorId.mesAidesReno => MesAidesRenoWidget(isDone: action.isDone),
        ActionSimulatorId.maif => MaifWidget(action: action),
        ActionSimulatorId.winter => const WinterWidget(),
      },
    ],
  );
}

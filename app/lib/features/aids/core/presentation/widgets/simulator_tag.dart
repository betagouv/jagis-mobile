import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class SimulatorTag extends StatelessWidget {
  const SimulatorTag({super.key});

  @override
  Widget build(final BuildContext context) => const DsfrTag(
    label: Localisation.simulateur,
    size: DsfrComponentSize.sm,
    backgroundColor: Color(0xFFEEF2FF),
    textColor: DsfrColors.blueFranceSun113,
    icon: DsfrIcons.financeMoneyEuroCircleLine,
  );
}

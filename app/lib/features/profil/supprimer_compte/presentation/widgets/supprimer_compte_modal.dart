import 'package:app/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class SupprimerCompteModal extends StatelessWidget {
  const SupprimerCompteModal({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(Localisation.supprimerVotreCompteConfirmation, style: DsfrTextStyle.headline4(color: DsfrColors.grey50)),
      const SizedBox(height: DsfrSpacings.s2w),
      const Text(Localisation.supprimerVotreCompteContenu, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
      const Text(
        Localisation.attentionAucuneDonneeNePourraEtreRecuperee,
        style: DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50),
      ),
      const SizedBox(height: DsfrSpacings.s4w),
      DsfrButton(
        label: Localisation.confirmer,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(true),
      ),
      const SizedBox(height: DsfrSpacings.s2w),
      DsfrButton(
        label: Localisation.annuler,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(false),
      ),
    ],
  );
}

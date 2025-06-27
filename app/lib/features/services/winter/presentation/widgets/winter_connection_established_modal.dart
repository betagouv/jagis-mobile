import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class WinterConnectionEstablishedModal extends StatelessWidget {
  const WinterConnectionEstablishedModal({super.key});

  @override
  Widget build(final BuildContext context) => const Column(
    spacing: DsfrSpacings.s5w,
    children: [FnvImage.asset(AssetImages.bulbOnIllustration, height: 100), _Content(), _Buttons()],
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s1w,
    children: [
      Text(Localisation.connexionEtablie, style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context))),
      Text(
        Localisation.cesInformationsSontEllesCorrectes,
        style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
      ),
      const _PrmInfo(),
    ],
  );
}

class _PrmInfo extends StatelessWidget {
  const _PrmInfo();

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: DsfrColorDecisions.backgroundAltBlueFrance(context),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s2w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s1w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: [
          Text('Mr BOUTIN', style: DsfrTextStyle.bodyMdBold(color: DsfrColorDecisions.textLabelGrey(context))),
          DsfrTag(label: Localisation.a('Hermival-Les-Vaux'), size: DsfrComponentSize.md),
          Text(
            Localisation.compteur('3972484935729898'),
            style: DsfrTextStyle.bodyMdBold(color: DsfrColorDecisions.textLabelGrey(context)),
          ),
        ],
      ),
    ),
  );
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s2w,
    children: [
      DsfrButton(
        label: Localisation.modifierLeNumero,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(false),
      ),
      DsfrButton(
        label: Localisation.continuer,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(true),
      ),
    ],
  );
}

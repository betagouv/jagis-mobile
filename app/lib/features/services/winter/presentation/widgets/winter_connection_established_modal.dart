import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class WinterConnectionEstablishedModal extends StatelessWidget {
  const WinterConnectionEstablishedModal({super.key, required this.lastName, required this.city, required this.prm});

  final String lastName;
  final String city;
  final String prm;

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s5w,
    children: [
      const FnvImage.asset(AssetImages.bulbOnIllustration, height: 100),
      _Content(lastName: lastName, city: city, prm: prm),
      const _Buttons(),
    ],
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.lastName, required this.city, required this.prm});

  final String lastName;
  final String city;
  final String prm;

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
      _PrmInfo(lastName: lastName, city: city, prm: prm),
    ],
  );
}

class _PrmInfo extends StatelessWidget {
  const _PrmInfo({required this.lastName, required this.city, required this.prm});

  final String lastName;
  final String city;
  final String prm;

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
          Text(lastName, style: DsfrTextStyle.bodyMdBold(color: DsfrColorDecisions.textLabelGrey(context))),
          DsfrTag(label: Localisation.a(city), size: DsfrComponentSize.md),
          Text(Localisation.compteur(prm), style: DsfrTextStyle.bodyMdBold(color: DsfrColorDecisions.textLabelGrey(context))),
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

import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/profil/profil/presentation/pages/profil_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class WinterConnectionEstablishedModal extends StatelessWidget {
  const WinterConnectionEstablishedModal({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s5w,
    children: [
      const FnvImage.asset(AssetImages.bulbOnIllustration, width: 100, height: 100),
      const _Content(),
      DsfrButton(
        label: Localisation.continuer,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(true),
      ),
    ],
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
      const _Description(),
    ],
  );
}

class _Description extends StatefulWidget {
  const _Description();

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  late final TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        await GoRouter.of(context).pushNamed(ProfilPage.name);
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      text: Localisation.cesInformationsSontEllesCorrectes,
      children: [
        const TextSpan(text: ' '),
        TextSpan(
          text: Localisation.votreProfil,
          style: DsfrTextStyle.bodyMd(
            color: DsfrColorDecisions.textActiveBlueFrance(context),
          ).copyWith(decoration: TextDecoration.underline),
          recognizer: _tapGestureRecognizer,
        ),
        const TextSpan(text: '.'),
      ],
    ),
    style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
  );
}

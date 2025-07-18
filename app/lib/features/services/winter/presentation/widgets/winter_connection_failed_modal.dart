import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class WinterConnectionFailedModal extends StatelessWidget {
  const WinterConnectionFailedModal({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s5w,
    children: [
      const FnvImage.asset(AssetImages.bulbOffIllustration, height: 100),
      const _Content(),
      DsfrButton(
        label: Localisation.retour,
        variant: DsfrButtonVariant.secondary,
        size: DsfrComponentSize.lg,
        onPressed: () => GoRouter.of(context).pop(false),
      ),
    ],
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s2w,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s1w,
        children: [
          Text(Localisation.laConnexionAEchoue, style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context))),
          Text(
            Localisation.laConnexionAEchoueDescription,
            style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
          ),
        ],
      ),
      const ColoredBox(
        color: DsfrColors.blueEcume975,
        child: Padding(
          padding: EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s1w,
            children: [
              Icon(DsfrIcons.systemFrInfoFill, color: DsfrColors.blueFranceSun113),
              Expanded(child: FnvMarkdown(data: Localisation.laConnexionAEchoueAstuce)),
            ],
          ),
        ),
      ),
    ],
  );
}

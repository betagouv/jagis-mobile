import 'dart:ui';

import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/animation_shake.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ActionsRecommandedSection extends StatelessWidget {
  const ActionsRecommandedSection({super.key});

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF3EDE5),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s4w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s6w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.mesActionsRecommandees, style: DsfrTextStyle.headline3()),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.mesActionsRecommandeesDescription, style: DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s2w),
          Stack(
            children: [
              ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: const Placeholder()),
              const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s4w), child: _GetStarted())),
            ],
          ),
        ],
      ),
    ),
  );
}

class _GetStarted extends StatelessWidget {
  const _GetStarted();

  @override
  Widget build(final context) => FnvCard(
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s3w,
        top: DsfrSpacings.s3w,
        right: DsfrSpacings.s3w,
        bottom: DsfrSpacings.s4w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Envie d’avoir un vrai impact ?', style: DsfrTextStyle.headline5()),
          const SizedBox(height: DsfrSpacings.s1v),
          MarkdownBody(
            data: 'Laissez-vous guider par nos recommandations d’actions **choisies pour vous !**',
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          AnimationShake(
            child: DsfrRawButton(
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: Text('Commencer')),
                  const SizedBox(width: DsfrSpacings.s1w),
                  FnvSvg.asset(AssetImages.leaf),
                  const Text('+90'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

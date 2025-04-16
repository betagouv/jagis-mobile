import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/gamification/reset/infrastructure/reset_repository.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetModal extends StatefulWidget {
  const ResetModal({super.key});

  @override
  State<ResetModal> createState() => _ResetModalState();
}

class _ResetModalState extends State<ResetModal> {
  var _showStep2 = false;

  void _goToStep2() {
    setState(() {
      _showStep2 = true;
    });
  }

  @override
  Widget build(final BuildContext context) =>
      _showStep2
          ? _Step2View(
            onResetPressed: () async {
              await context.read<ResetRepository>().reset();
              if (context.mounted) {
                context.read<MessageBus>().publish(resetPointsTopic);
                Navigator.of(context).pop();
              }
            },
          )
          : _Step1View(onContinuePressed: _goToStep2);
}

class _Step1View extends StatelessWidget {
  const _Step1View({required this.onContinuePressed});

  final VoidCallback onContinuePressed;

  @override
  Widget build(final BuildContext context) => _View(
    title: Localisation.ilYADuNouveauSurApp,
    imagePath: AssetImages.resetPointsIllustrations1,
    descriptionMarkdown: Localisation.ilYADuNouveauSurAppDescription,
    button: _ContinueButton(onPressed: onContinuePressed),
  );
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => DsfrButton(
    label: Localisation.continuer,
    icon: DsfrIcons.systemArrowRightSLine,
    iconLocation: DsfrButtonIconLocation.right,
    variant: DsfrButtonVariant.secondary,
    size: DsfrComponentSize.lg,
    onPressed: onPressed,
  );
}

class _Step2View extends StatelessWidget {
  const _Step2View({required this.onResetPressed});

  final VoidCallback onResetPressed;

  @override
  Widget build(final BuildContext context) => _View(
    title: Localisation.merciPourVotreSoutien,
    imagePath: AssetImages.resetPointsIllustrations2,
    descriptionMarkdown: Localisation.merciPourVotreSoutienDescription,
    extra: const _PioneerBadge(),
    button: _ResetButton(onPressed: onResetPressed),
  );
}

class _PioneerBadge extends StatelessWidget {
  const _PioneerBadge();

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: DsfrColors.blueFrance975.withAlpha(77),
      border: const Border.fromBorderSide(BorderSide(color: DsfrColors.blueFrance950)),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s1v, horizontal: DsfrSpacings.s1w),
      child: Row(
        spacing: DsfrSpacings.s1w,
        children: [
          FnvImage.asset(AssetImages.badgePionner, width: 54, height: 54),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Localisation.pionnier, style: DsfrTextStyle.bodyMdBold()),
                Text(Localisation.pionnierDescription, style: DsfrTextStyle.bodySm()),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => DsfrRawButton(
    variant: DsfrButtonVariant.primary,
    size: DsfrComponentSize.lg,
    onPressed: onPressed,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(child: Text(Localisation.recolter)),
          const SizedBox(width: DsfrSpacings.s1v),
          const Text('200'),
          FnvSvg.asset(AssetImages.leaf),
        ],
      ),
    ),
  );
}

class _View extends StatelessWidget {
  const _View({
    required this.title,
    required this.imagePath,
    required this.descriptionMarkdown,
    this.extra,
    required this.button,
  });

  final String title;
  final String imagePath;
  final String descriptionMarkdown;
  final Widget? extra;
  final Widget button;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const DsfrTextStyle.headline3()),
      const SizedBox(height: DsfrSpacings.s2w),
      Center(child: FnvImage.asset(imagePath, height: 156)),
      const SizedBox(height: DsfrSpacings.s1w),
      FnvMarkdown(data: descriptionMarkdown),
      if (extra != null) ...[const SizedBox(height: DsfrSpacings.s2w), extra!],
      const SizedBox(height: DsfrSpacings.s5w),
      Align(alignment: Alignment.centerRight, child: FittedBox(child: button)),
    ],
  );
}

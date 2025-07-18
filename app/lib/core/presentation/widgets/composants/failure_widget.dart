import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvFailureWidget extends StatelessWidget {
  const FnvFailureWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Localisation.erreurInattendue, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
        FnvSvg.asset(AssetImages.errorIllustration),
        const Text(Localisation.erreurInattendueContent, style: DsfrTextStyle.bodyXl(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s4w),
        DsfrButton(
          label: Localisation.rafraichir,
          variant: DsfrButtonVariant.secondary,
          size: DsfrComponentSize.lg,
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

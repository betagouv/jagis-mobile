import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterStartWidget extends StatelessWidget {
  const WinterStartWidget({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(Localisation.winterTitre, style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context))),
      const SizedBox(height: DsfrSpacings.s1w),
      Text(Localisation.winterDescription, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: DsfrSpacings.s5w),
            child: DsfrButton(
              label: Localisation.commencer,
              variant: DsfrButtonVariant.primary,
              size: DsfrComponentSize.lg,
              onPressed: () => context.read<WinterBloc>().add(const WinterStarted()),
            ),
          ),
          const Expanded(child: FnvImage.asset(AssetImages.wattWatchersIllustration)),
        ],
      ),
    ],
  );
}

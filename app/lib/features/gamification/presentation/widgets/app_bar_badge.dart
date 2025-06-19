import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/gamification/presentation/widgets/achievement_base.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class AppBarBadge extends StatelessWidget {
  const AppBarBadge({super.key, required this.value, required this.onTap});

  final int value;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    const size = DsfrSpacings.s2w;

    return Semantics(
      label: Localisation.nombreBadges(value),
      child: AchievementBase(
        icon: const FnvImage.asset(AssetImages.badgeIcon, width: size, height: size),
        backgroundColor: const Color(0xFFFEF4DA),
        value: value,
        onTap: onTap,
      ),
    );
  }
}

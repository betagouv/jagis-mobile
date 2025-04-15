import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/ranking/domain/achievement_badge.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class BadgeItem extends StatelessWidget {
  const BadgeItem({super.key, required this.badge});

  final AchievementBadge badge;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardBoxShadow),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s1w),
      child: Row(
        spacing: DsfrSpacings.s3v,
        children: [
          FnvImage.network(badge.imageUrl, width: 63, height: 63, fit: BoxFit.cover),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(badge.title, style: const DsfrTextStyle.bodyLgBold()),
                Text(badge.description, style: const DsfrTextStyle.bodyMd(color: Color(0xFF747474))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

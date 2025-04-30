import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/gamification/presentation/widgets/points_widget.dart';
import 'package:app/features/ranking/domain/user_rank.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class RankItem extends StatelessWidget {
  const RankItem({super.key, required this.userRank, required this.isCurrentUser});

  final UserRank userRank;
  final bool isCurrentUser;

  @override
  Widget build(final BuildContext context) {
    final borderColor = isCurrentUser ? DsfrColors.blueFranceMain525 : FnvColors.carteFond;
    final backgroundColor = isCurrentUser ? DsfrColors.blueFrance925 : FnvColors.carteFond;
    final pseudo = userRank.pseudo;

    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor, border: Border.all(color: borderColor), boxShadow: cardShadow),
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Row(
          spacing: DsfrSpacings.s1w,
          children: [
            _RankDisplay(rank: userRank.rank),
            Expanded(child: pseudo == null ? const SizedBox.shrink() : Text(pseudo, style: const DsfrTextStyle.bodyMdBold())),
            PointsWidget(points: userRank.points, backgroundColor: FnvColors.carteFond),
          ],
        ),
      ),
    );
  }
}

class _RankDisplay extends StatelessWidget {
  const _RankDisplay({required this.rank});

  final int rank;

  @override
  Widget build(final BuildContext context) => switch (rank) {
    1 => const _Rank(
      backgroundColor: Color(0xFFFEFBDB),
      borderColor: Color(0xFFFAE5B6),
      child: Text('🥇', style: DsfrTextStyle.headline4()),
    ),
    2 => const _Rank(
      backgroundColor: Color(0xFFFAFAFA),
      borderColor: Color(0xFFE3E3E3),
      child: Text('🥈', style: DsfrTextStyle.headline4()),
    ),
    3 => const _Rank(
      backgroundColor: Color(0xFFFEECD9),
      borderColor: Color(0xFFE7B6AD),
      child: Text('🥉', style: DsfrTextStyle.headline4()),
    ),
    _ => _Rank(
      backgroundColor: Colors.white,
      borderColor: DsfrColors.grey975Active,
      child: Text(rank.toString(), style: const DsfrTextStyle.bodyMdBold()),
    ),
  };
}

class _Rank extends StatelessWidget {
  const _Rank({required this.backgroundColor, required this.borderColor, required this.child});

  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: backgroundColor, border: Border.fromBorderSide(BorderSide(color: borderColor))),
    child: SizedBox.square(dimension: 38, child: Center(child: child)),
  );
}

import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalPoints extends StatelessWidget {
  const GlobalPoints({super.key});

  @override
  Widget build(final context) {
    final points = context.select<GamificationBloc, int>((final value) => value.state.points);

    return _Points(points: points);
  }
}

class Points extends StatelessWidget {
  const Points({super.key, required this.points, this.alreadyEarned = false});

  final int points;
  final bool alreadyEarned;

  @override
  Widget build(final context) =>
      alreadyEarned
          ? _Points(points: points, backgroundColor: DsfrColors.backgroundContrastGrey, textColor: DsfrColors.textDefaultGrey)
          : _Points(points: points);
}

class _Points extends StatelessWidget {
  const _Points({required this.points, this.backgroundColor = const Color(0xFFF1F6EC), this.textColor = const Color(0xFF3CD277)});

  final int points;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v5, horizontal: DsfrSpacings.s1w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1v,
        children: [
          Text('$points', style: const DsfrTextStyle.bodySmBold(), semanticsLabel: Localisation.nombrePoints(points)),
          ExcludeSemantics(child: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: textColor)),
        ],
      ),
    ),
  );
}

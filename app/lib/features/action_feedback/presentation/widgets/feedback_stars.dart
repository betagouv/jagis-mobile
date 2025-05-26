// ignore_for_file: prefer-spacing

import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FeedbackStars extends StatelessWidget {
  const FeedbackStars({super.key, required this.size, required this.value, required this.onChanged});

  final double size;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(final BuildContext context) {
    const maxStars = 4;

    return Semantics(
      button: false,
      label: '$value étoile sur $maxStars',
      child: Row(
        spacing: DsfrSpacings.s1v,
        children: List.generate(maxStars, (final index) {
          final rateSelected = index + 1;

          return InkWell(
            onTap: () => onChanged(rateSelected),
            child: Semantics(
              enabled: true,
              button: true,
              label: rateSelected <= 1 ? '$rateSelected étoile sur $maxStars' : '$rateSelected étoiles sur $maxStars',
              child: _Star(size: size, value: value, starValue: rateSelected),
            ),
          );
        }, growable: false),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({required this.size, required this.value, required this.starValue});

  final double size;
  final int value;
  final int starValue;

  @override
  Widget build(final BuildContext context) => value >= starValue
      ? Icon(DsfrIcons.systemStarFill, size: size, color: DsfrColors.blueFranceSun113)
      : Icon(DsfrIcons.systemStarLine, size: size, color: const Color(0xFF636774));
}

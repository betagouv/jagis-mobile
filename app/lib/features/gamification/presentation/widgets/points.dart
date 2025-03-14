import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Points extends StatelessWidget {
  const Points({super.key, this.points});

  final int? points;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: const BoxDecoration(color: Color(0xFFF1F6EC), borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1v5, horizontal: DsfrSpacings.s1w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1v,
        children: [
          _Content(points),
          const ExcludeSemantics(child: Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w, color: Color(0xFF3CD277))),
        ],
      ),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content(this.points);

  final int? points;

  @override
  Widget build(final BuildContext context) {
    final points = this.points ?? context.select<GamificationBloc, int>((final value) => value.state.points);

    return Text('$points', style: const DsfrTextStyle.bodySmBold(), semanticsLabel: Localisation.nombrePoints(points));
  }
}

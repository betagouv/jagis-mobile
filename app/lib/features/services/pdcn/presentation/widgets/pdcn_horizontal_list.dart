// ignore_for_file: prefer-single-widget-per-file

import 'package:app/features/services/pdcn/presentation/bloc/pdcn_bloc.dart';
import 'package:app/features/services/pdcn/presentation/bloc/pdcn_event.dart';
import 'package:app/features/services/pdcn/presentation/bloc/pdcn_state.dart';
import 'package:app/features/services/pdcn/presentation/widgets/pdcn_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdcnHorizontalList extends StatelessWidget {
  const PdcnHorizontalList({super.key, required this.category});

  final String category;

  @override
  Widget build(final BuildContext context) =>
      BlocProvider(create: (final context) => PdcnBloc(context.read())..add(PdcnLoadRequested(category)), child: const _Part());
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final BuildContext context) => BlocBuilder<PdcnBloc, PdcnState>(
    builder: (final context, final state) => switch (state) {
      PdcnInitial() || PdcnLoadInProgress() || PdcnLoadFailure() => const SizedBox.shrink(),
      PdcnLoadSuccess() => _Success(success: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.success});

  final PdcnLoadSuccess success;

  @override
  Widget build(final BuildContext context) {
    if (success.list.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1w,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Localisation.mesCommerces, style: DsfrTextStyle.headline4()),
              Text(Localisation.pdcnSousTitre, style: DsfrTextStyle.bodyMd()),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: success.list.map((final e) => PdcnCard(e: e)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

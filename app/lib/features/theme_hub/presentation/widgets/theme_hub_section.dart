import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme_hub/domain/theme_hub_model.dart';
import 'package:app/features/theme_hub/presentation/bloc/theme_hub_bloc.dart';
import 'package:app/features/theme_hub/presentation/bloc/theme_hub_event.dart';
import 'package:app/features/theme_hub/presentation/bloc/theme_hub_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ThemeHubSection extends StatelessWidget {
  const ThemeHubSection({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => ThemeHubBloc(repository: context.read())..add(const ThemeHubLoadRequested()),
    child: const _Section(),
  );
}

class _Section extends StatelessWidget {
  const _Section();

  @override
  Widget build(final context) => BlocBuilder<ThemeHubBloc, ThemeHubState>(
    builder:
        (final context, final state) => switch (state) {
          ThemeHubInitial() || ThemeHubLoadInProgress() => const SizedBox.shrink(),
          ThemeHubLoadSuccess() => _Success(value: state),
          ThemeHubLoadFailure() => const Center(child: Text('Une erreur est survenue')),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.value});

  final ThemeHubLoadSuccess value;

  @override
  Widget build(final context) => ColoredBox(
    color: DsfrColors.blueFrance975,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s2w,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Text(Localisation.parOuSouhaitezVousCommencer, style: DsfrTextStyle.headline2()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: MarkdownBody(
              data: Localisation.parOuSouhaitezVousCommencerDescription(value.model.city),
              styleSheet: MarkdownStyleSheet(
                p: const DsfrTextStyle.bodyMd(),
                strong: const DsfrTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: DsfrColors.blueFranceSun113,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
              child: IntrinsicHeight(child: Row(spacing: DsfrSpacings.s2w, children: value.model.themes.map(_Item.new).toList())),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item(this.item);

  final ThemeHubThemeSummary item;

  @override
  Widget build(final context) => FnvCard(
    child: SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(
          left: DsfrSpacings.s1w,
          top: DsfrSpacings.s1w,
          right: DsfrSpacings.s1w,
          bottom: DsfrSpacings.s2w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.themeType.displayName, style: const DsfrTextStyle.bodyLgBold()),
            const SizedBox(height: DsfrSpacings.s1w),
            const DsfrDivider(),
            const SizedBox(height: DsfrSpacings.s1w),
            if (item.details.isNotEmpty) _Details(details: item.details),
            const SizedBox(height: DsfrSpacings.s3w),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 152,
                child: DsfrButton(
                  label: Localisation.decouvrir,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: () {
                    switch (item.themeType) {
                      case ThemeType.alimentation:
                        DefaultTabController.of(context).animateTo(1);
                      case ThemeType.transport:
                        DefaultTabController.of(context).animateTo(2);
                      case ThemeType.logement:
                        DefaultTabController.of(context).animateTo(3);
                      case ThemeType.consommation:
                        DefaultTabController.of(context).animateTo(4);
                      case ThemeType.decouverte:
                        throw UnimplementedError();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Details extends StatelessWidget {
  const _Details({required this.details});

  final Map<ThemeHubDetailType, int> details;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1v,
    children: [
      ...details.entries.map((final e) {
        final s = switch (e.key) {
          ThemeHubDetailType.action => 'idées d’actions',
          ThemeHubDetailType.aid => 'aides sur votre territoire',
          ThemeHubDetailType.recipe => 'recettes délicieuses, saines et de saison',
          ThemeHubDetailType.simulator => 'simulateurs',
        };

        return MarkdownBody(data: '- **${e.value}** $s', styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodySm()));
      }),
    ],
  );
}

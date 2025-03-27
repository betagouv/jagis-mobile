import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/home/home_recommendations/bloc/home_recommendations_bloc.dart';
import 'package:app/features/home/home_recommendations/bloc/home_recommendations_event.dart';
import 'package:app/features/home/home_recommendations/bloc/home_recommendations_state.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeRecommendations extends StatelessWidget {
  const HomeRecommendations({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => HomeRecommendationsBloc(repository: context.read())..add(const HomeRecommendationsLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<HomeRecommendationsBloc, HomeRecommendationsState>(
    builder:
        (final context, final state) => switch (state) {
          HomeRecommendationsLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
          HomeRecommendationsInitial() || HomeRecommendationsLoadInProgress() => const _Success([]),
          HomeRecommendationsLoadSuccess(:final recommendations) => _Success(recommendations),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success(this.recommendations);

  final List<Recommandation> recommendations;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(Localisation.quoiDeNeuf, style: DsfrTextStyle.headline3()),
            DsfrLink.md(
              label: Localisation.toutVoir,
              onTap: () => GoRouter.of(context).pushReplacementNamed(BibliothequePage.name),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children:
                  recommendations
                      .map(
                        (final e) => RecommendationWidget(
                          id: e.id,
                          type: e.type,
                          points: '${e.points}',
                          imageUrl: e.imageUrl,
                          themeTag: ThemeTypeTag(themeType: e.thematique),
                          titre: e.titre,
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

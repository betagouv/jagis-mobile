import 'package:app/features/home/bloc/home_dashboard_bloc.dart';
import 'package:app/features/home/bloc/home_dashboard_event.dart';
import 'package:app/features/library/presentation/pages/library_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeRecommendations extends StatelessWidget {
  const HomeRecommendations(this.recommendations, {super.key});

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
          children: [
            const Expanded(child: Text(Localisation.quoiDeNeuf, style: DsfrTextStyle.headline3())),
            DsfrLink.md(
              label: Localisation.voirTout,
              onTap: () async {
                await GoRouter.of(context).pushNamed(LibraryPage.name);
              },
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: recommendations
                  .map(
                    (final e) => RecommendationWidget(
                      id: e.id,
                      imageUrl: e.imageUrl,
                      titre: e.titre,
                      onPop: () => context.read<HomeDashboardBloc>().add(const HomeDashboardRecommandationsUpdated()),
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

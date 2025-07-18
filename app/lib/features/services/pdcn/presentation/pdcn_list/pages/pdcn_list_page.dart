import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/address/address_search_widget.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/partner_card.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/services/core/bloc/service_bloc.dart';
import 'package:app/features/services/core/bloc/service_event.dart';
import 'package:app/features/services/core/bloc/service_state.dart';
import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:app/features/services/pdcn/domain/pdcn_summary.dart';
import 'package:app/features/services/pdcn/infrastructure/pdcn_summary_mapper.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/pages/pdcn_detail_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class PdcnListPage extends StatelessWidget {
  const PdcnListPage({super.key});

  static const name = 'pres-de-chez-nous';
  static const path = name;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => const PdcnListPage(),
    routes: [PdcnDetailPage.route],
  );

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) =>
          ServiceBloc<PdcnSummary>(ServiceRepository(context.read()), 'proximite', 9, PdcnSummaryMapper.fromJson)
            ..add(const ServiceLoadRequested()),
      child: const _Body(),
    ),
  );
}

final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<ServiceBloc<PdcnSummary>, ServiceState<PdcnSummary>>(
    builder: (final context, final state) => switch (state.status) {
      ServiceStatus.initial => const SizedBox(),
      ServiceStatus.loading => const Center(child: CircularProgressIndicator()),
      ServiceStatus.failure => const Center(child: Text('Erreur de chargement')),
      ServiceStatus.success => _Success(current: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.current});

  final ServiceState<PdcnSummary> current;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ServiceCategoriesInput(categories: current.categories, selected: current.categorySelected),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.pdcnSousTitre, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s3w),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(Localisation.rechercherParAdresse, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
                  AddressSearchWidget(
                    onSelected: (final option) =>
                        context.read<ServiceBloc<PdcnSummary>>().add(ServiceAddressChanged(address: option)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          if (current.results.suggestions.isEmpty) ...[
            const FnvImage.asset(AssetImages.serviceAucunResultat),
            const Text(
              Localisation.serviceAucunResultat,
              style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            const Text(Localisation.suggestions, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
            const SizedBox(height: DsfrSpacings.s3w),
            ...current.results.suggestions
                .map((final e) => _Card(suggestion: e))
                .separator(const SizedBox(height: DsfrSpacings.s3w)),
            if (current.results.moreResultsAvailable) ...[
              const SizedBox(height: DsfrSpacings.s3w),
              Center(
                child: DsfrButton(
                  label: Localisation.afficherPlusDeSuggestions,
                  variant: DsfrButtonVariant.secondary,
                  size: DsfrComponentSize.lg,
                  onPressed: () => context.read<ServiceBloc<PdcnSummary>>().add(const ServiceSeeMore()),
                ),
              ),
            ],
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          const SafeArea(
            child: PartnerCard(
              image: AssetImages.pdcnIllustration,
              name: Localisation.pdcnNom,
              description: Localisation.pdcnDescription,
              url: Localisation.pdcnUrl,
            ),
          ),
        ],
      ),
    ),
  );
}

class _ServiceCategoriesInput extends StatelessWidget {
  const _ServiceCategoriesInput({required this.categories, required this.selected});

  final ServiceCategories categories;
  final ServiceCategory selected;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      style: const DsfrTextStyle(fontSize: 28, fontWeight: FontWeight.w500),
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: FnvDropdown<ServiceCategory>(
            items: Map.fromEntries(categories.elements.map((final e) => MapEntry(e, e.label))),
            value: selected,
            onChanged: (final value) => context.read<ServiceBloc<PdcnSummary>>().add(ServiceCategoryChanged(category: value)),
          ),
        ),
        const TextSpan(text: ' à proximité de chez moi'),
      ],
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.suggestion});

  final PdcnSummary suggestion;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(PdcnDetailPage.name, pathParameters: {'id': suggestion.id});
    },
    child: Row(
      children: [
        const FnvImage.asset(AssetImages.pdcnStore, width: 88, height: 140, fit: BoxFit.cover),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsfrSpacings.s0v5,
                  children: [
                    Text(
                      suggestion.name,
                      style: DsfrTextStyle.headline5(color: DsfrColorDecisions.textTitleGrey(context)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (suggestion.description != null)
                      Text(
                        suggestion.description!,
                        style: DsfrTextStyle.bodySmBold(color: DsfrColorDecisions.textLabelGrey(context)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    Text(
                      suggestion.address,
                      style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textDefaultGrey(context)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                DsfrTag(
                  label: Localisation.distance(suggestion.distanceInMeters),
                  size: DsfrComponentSize.sm,
                  backgroundColor: DsfrColors.blueCumulus950,
                  textColor: DsfrColors.blueFranceSun113,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

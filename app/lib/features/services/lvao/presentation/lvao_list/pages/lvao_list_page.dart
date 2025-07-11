import 'package:app/core/address/geocoding_repository.dart';
import 'package:app/core/assets/images.dart';
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
import 'package:app/features/services/lvao/domain/lvao_actor.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/pages/lvao_detail_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class LvaoListPage extends StatelessWidget {
  const LvaoListPage({super.key});

  static const name = 'longue-vie-aux-objets';
  static const path = name;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => const LvaoListPage(),
    routes: [LvaoDetailPage.route],
  );

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) =>
          ServiceBloc<LvaoActor>(ServiceRepository(context.read()), 'longue_vie_objets', 9, LvaoActor.fromJson)
            ..add(const ServiceLoadRequested()),
      child: const _Body(),
    ),
  );
}

final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<ServiceBloc<LvaoActor>, ServiceState<LvaoActor>>(
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

  final ServiceState<LvaoActor> current;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ServiceCategoriesInput(categories: current.categories, selected: current.categorySelected),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.lvaoSousTitre, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s3w),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(Localisation.rechercherParAdresse, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
                  FnvAutocomplete(
                    displayStringForOption: (final option) => option.label,
                    onSearch: (final query) => context.read<GeocodingRepository>().search(query),
                    onSelected: (final option) =>
                        context.read<ServiceBloc<LvaoActor>>().add(ServiceAddressChanged(address: option)),
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
              DsfrLink(
                label: Localisation.voirPlus,
                onTap: () => context.read<ServiceBloc<LvaoActor>>().add(const ServiceSeeMore()),
              ),
            ],
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          const PartnerCard(
            image: AssetImages.lvaoIllustration,
            name: Localisation.lvaoNom,
            description: Localisation.lvaoDescription,
            url: Localisation.lvaoUrl,
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
            onChanged: (final value) => context.read<ServiceBloc<LvaoActor>>().add(ServiceCategoryChanged(category: value)),
          ),
        ),
        const TextSpan(text: ' à proximité de chez moi'),
      ],
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.suggestion});

  final LvaoActor suggestion;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(LvaoDetailPage.name, pathParameters: {'id': suggestion.id});
    },
    child: IntrinsicHeight(
      child: Row(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffF2EAF8)),
            child: FnvImage.asset(AssetImages.lvaoStore, width: 72, fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.name,
                    style: const DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    suggestion.address,
                    style: const DsfrTextStyle.bodyXs(color: DsfrColors.grey50),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  if (suggestion.distanceInMeters != null) ...[
                    const Spacer(),
                    DsfrTag(
                      label: Localisation.distance(suggestion.distanceInMeters!),
                      size: DsfrComponentSize.sm,
                      backgroundColor: const Color(0xffEAEAEA),
                      textColor: const Color(0xff3F3F3F),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

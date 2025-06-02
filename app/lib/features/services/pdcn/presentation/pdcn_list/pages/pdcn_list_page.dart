import 'package:app/core/address/address_repository.dart';
import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/autocomplete.dart';
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
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ServiceStatus.success => ListView(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
        children: [
          _ServiceCategoriesInput(categories: state.categories, selected: state.categorySelected),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.pdcnSousTitre, style: DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s3w),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(Localisation.rechercherParAdresse, style: DsfrTextStyle.headline3()),
                  FnvAutocomplete(
                    displayStringForOption: (final option) => option.label,
                    onSearch: (final query) => context.read<AddressRepository>().search(query),
                    onSelected: (final option) =>
                        context.read<ServiceBloc<PdcnSummary>>().add(ServiceAddressChanged(address: option)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          if (state.suggestions.isEmpty) ...[
            const FnvImage.asset(AssetImages.serviceAucunResultat),
            const Text(Localisation.serviceAucunResultat, style: DsfrTextStyle.bodyLg(), textAlign: TextAlign.center),
          ] else ...[
            const Text(Localisation.suggestions, style: DsfrTextStyle.headline3()),
            const SizedBox(height: DsfrSpacings.s3w),
            ...state.suggestions.map((final e) => _Card(suggestion: e)).separator(const SizedBox(height: DsfrSpacings.s3w)),
          ],
          const SizedBox(height: DsfrSpacings.s3w),
          const PartnerCard(
            image: AssetImages.pdcnIllustration,
            name: Localisation.pdcnNom,
            description: Localisation.pdcnDescription,
            url: Localisation.pdcnUrl,
          ),
        ],
      ),
    },
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
    child: IntrinsicHeight(
      child: Row(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(color: Color(0xffF2EAF8)),
            child: FnvImage.asset(AssetImages.pdcnStore, width: 72, fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(suggestion.name, style: const DsfrTextStyle.bodyMdBold(), overflow: TextOverflow.ellipsis, maxLines: 1),
                  Text(suggestion.address, style: const DsfrTextStyle.bodyXs(), overflow: TextOverflow.ellipsis, maxLines: 3),
                  const Spacer(),
                  DsfrTag.sm(
                    label: TextSpan(text: Localisation.distance(suggestion.distanceInMeters)),
                    backgroundColor: const Color(0xffEAEAEA),
                    foregroundColor: const Color(0xff3F3F3F),
                    textStyle: const DsfrTextStyle.bodyXsMedium(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

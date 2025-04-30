import 'package:app/core/assets/images.dart';
import 'package:app/core/helpers/size.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/services/pres_de_chez_vous/presentation/bloc/pres_de_chez_vous_bloc.dart';
import 'package:app/features/services/pres_de_chez_vous/presentation/bloc/pres_de_chez_vous_event.dart';
import 'package:app/features/services/pres_de_chez_vous/presentation/bloc/pres_de_chez_vous_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresDeChezVousHorizontalList extends StatelessWidget {
  const PresDeChezVousHorizontalList({super.key, required this.category});

  final String category;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => PresDeChezVousBloc(context.read())..add(PresDeChezVousLoadRequested(category)),
    child: const _Part(),
  );
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final BuildContext context) => BlocBuilder<PresDeChezVousBloc, PresDeChezVousState>(
    builder:
        (final context, final state) => switch (state) {
          PresDeChezVousInitial() || PresDeChezVousLoadInProgress() || PresDeChezVousLoadFailure() => const SizedBox.shrink(),
          PresDeChezVousLoadSuccess() => _Success(success: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.success});

  final PresDeChezVousLoadSuccess success;

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
              Text(Localisation.mesCommercesDescription, style: DsfrTextStyle(fontSize: 16)),
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
              children:
                  success.list
                      .map(
                        (final e) => DecoratedBox(
                          decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
                          child: SizedBox(
                            width: screenWidth(context, percentage: 0.7),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const DecoratedBox(
                                  decoration: BoxDecoration(color: Color(0xffF2EAF8)),
                                  child: FnvImage.asset(AssetImages.presDeChezVousStore, width: 72, fit: BoxFit.fitHeight),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(DsfrSpacings.s2w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.name, style: const DsfrTextStyle.bodyMdBold()),
                                        Text(
                                          e.address,
                                          style: const DsfrTextStyle.bodyXs(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        const Spacer(),
                                        DsfrTag.sm(
                                          label: TextSpan(text: Localisation.distance(e.distanceInMeters)),
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
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

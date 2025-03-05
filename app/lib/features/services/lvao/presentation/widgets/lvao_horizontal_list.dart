import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/lvao/presentation/bloc/lvao_bloc.dart';
import 'package:app/features/services/lvao/presentation/bloc/lvao_event.dart';
import 'package:app/features/services/lvao/presentation/bloc/lvao_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LvaoHorizontalList extends StatelessWidget {
  const LvaoHorizontalList({super.key, required this.category});

  final String category;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => LvaoBloc(repository: context.read())..add(LvaoLoadRequested(category)),
    child: const _Part(),
  );
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final BuildContext context) => BlocBuilder<LvaoBloc, LvaoState>(
    builder:
        (final context, final state) => switch (state) {
          LvaoInitial() || LvaoLoadInProgress() || LvaoLoadFailure() => const SizedBox(),
          LvaoLoadSuccess() => _Success(state: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final LvaoLoadSuccess state;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FnvMarkdown(
              data: 'Où faire **réparer** ?', // TODO(lsaudon): Ajouter la ville
              p: DsfrTextStyle(fontSize: 22),
            ),
            Text(
              'Trouvez les cordonniers et réparateurs agréés près de chez vous pour bénéficier d’une aide d’État', // TODO(lsaudon): Texte pour réparation
              style: DsfrTextStyle(fontSize: 16),
            ),
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
                state.actors
                    .map(
                      (final e) => FnvCard(
                        child: SizedBox(
                          width: 346,
                          child: Padding(
                            padding: const EdgeInsets.all(DsfrSpacings.s1w),
                            child: Row(
                              spacing: DsfrSpacings.s2w,
                              children: [
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2EAF8),
                                    borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
                                  ),
                                  child: FnvImage.asset(AssetImages.lvaoStore, width: 72, height: 99),
                                ),
                                Expanded(
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
                              ],
                            ),
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

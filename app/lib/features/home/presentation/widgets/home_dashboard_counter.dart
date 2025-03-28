import 'package:app/core/assets/images.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeDashboardCounter extends StatelessWidget {
  const HomeDashboardCounter({super.key, required this.nbActionsDone, required this.bilanCarbonePercentageCompletion});

  final int nbActionsDone;
  final int bilanCarbonePercentageCompletion;

  @override
  Widget build(final BuildContext context) {
    const progressSize = 88.0;

    return DecoratedBox(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AssetImages.homeDashboardBg), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
                child: Column(
                  spacing: DsfrSpacings.s1v5,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const SizedBox.square(dimension: progressSize),
                        Text(nbActionsDone.toString(), style: const DsfrTextStyle(fontSize: 37, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                      Localisation.actionsTerminees(nbActionsDone),
                      style: const DsfrTextStyle.bodySm(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const DsfrDivider(width: 1, height: 150),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
                child: Column(
                  spacing: DsfrSpacings.s1v5,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox.square(
                          dimension: progressSize,
                          child: CircularProgressIndicator(
                            value: bilanCarbonePercentageCompletion / 100,
                            backgroundColor: const Color(0xFFE7E3DC),
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFA89F8E)),
                            strokeWidth: 4,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: bilanCarbonePercentageCompletion.toString(),
                            children: const [
                              TextSpan(text: '%', style: DsfrTextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          style: const DsfrTextStyle(fontSize: 37, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        if (bilanCarbonePercentageCompletion != 100)
                          const Text(
                            Localisation.monBilanEnvironnemental,
                            style: DsfrTextStyle.bodySm(),
                            textAlign: TextAlign.center,
                          ),
                        DsfrLink.sm(
                          label:
                              bilanCarbonePercentageCompletion == 100
                                  ? Localisation.monBilanEnvironnemental
                                  : Localisation.completer,
                          textAlign: TextAlign.center,
                          icon: DsfrIcons.systemArrowRightSLine,
                          iconPosition: DsfrLinkIconPosition.end,
                          onTap: () async => GoRouter.of(context).pushNamed(EnvironmentalPerformanceSummaryPage.name),
                        ),
                      ],
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
}

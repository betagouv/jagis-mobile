import 'package:app/core/helpers/input_formatter.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/partner_widget.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/pages/aid_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class AidSummaryCard extends StatelessWidget {
  const AidSummaryCard({super.key, required this.aidSummary, this.width});

  final AidSummary aidSummary;
  final double? width;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      context.read<Tracker>().trackClick(action: 'Aides', name: aidSummary.title);
      await GoRouter.of(context).pushNamed(
        AidPage.name,
        pathParameters: AidPage.pathParameters(title: aidSummary.title, id: aidSummary.id),
      );
    },
    child: SizedBox(
      width: width ?? double.infinity,
      child: Column(
        // fill height
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: DsfrSpacings.s1w,
                    children: [
                      if (aidSummary.hasSimulator) const SimulatorTag(),
                      Text(aidSummary.title, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
                      if (aidSummary.isFree) const _IsFree(),
                      if (aidSummary.maxAmount != null) _AmountMax(value: aidSummary.maxAmount!),
                    ],
                  ),
                ),
                const Icon(DsfrIcons.systemArrowRightSLine, color: DsfrColors.blueFranceSun113),
              ],
            ),
          ),
          if (aidSummary.partner != null)
            Ink(
              color: const Color(0xffeef2ff),
              child: PartnerWidget(partner: aidSummary.partner!),
            ),
        ],
      ),
    ),
  );
}

class _AmountMax extends StatelessWidget {
  const _AmountMax({required this.value});

  final int value;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      children: [
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(DsfrIcons.financeMoneyEuroCircleLine, color: DsfrColors.blueFranceSun113),
        ),
        const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
        const TextSpan(text: Localisation.jusqua),
        TextSpan(
          text: formatCurrencyWithSymbol(value),
          style: const DsfrTextStyle.bodySmBold(color: DsfrColors.grey50),
        ),
      ],
    ),
    style: const DsfrTextStyle.bodySm(color: DsfrColors.grey50),
  );
}

class _IsFree extends StatelessWidget {
  const _IsFree();

  @override
  Widget build(final BuildContext context) => const Text.rich(
    TextSpan(
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(DsfrIcons.financeMoneyEuroCircleLine, color: DsfrColors.blueFranceSun113),
        ),
        WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
        TextSpan(
          text: Localisation.gratuit,
          style: DsfrTextStyle.bodySmBold(color: DsfrColors.grey50),
        ),
      ],
    ),
    style: DsfrTextStyle.bodySm(color: DsfrColors.grey50),
  );
}

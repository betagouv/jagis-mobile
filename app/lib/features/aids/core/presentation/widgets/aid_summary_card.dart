import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/aids/core/presentation/widgets/partner_widget.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/pages/aid_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidSummaryCard extends StatelessWidget {
  const AidSummaryCard({super.key, required this.aidSummary, this.width});

  final AidSummary aidSummary;
  final double? width;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      context.read<Tracker>().trackClick('Aides', aidSummary.title);
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
                    children: [
                      if (aidSummary.hasSimulator) ...[const SimulatorTag(), const SizedBox(width: DsfrSpacings.s1w)],
                      Text(aidSummary.title, style: const DsfrTextStyle.bodyMd()),
                      if (aidSummary.isFree) ...[const SizedBox(height: DsfrSpacings.s1w), const _IsFree()],
                      if (aidSummary.maxAmount != null) ...[
                        const SizedBox(height: DsfrSpacings.s1w),
                        _AmountMax(value: aidSummary.maxAmount!),
                      ],
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
        TextSpan(text: Localisation.euro(value), style: const DsfrTextStyle.bodySmBold()),
      ],
    ),
    style: const DsfrTextStyle.bodySm(),
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
        TextSpan(text: Localisation.gratuit, style: DsfrTextStyle.bodySmBold()),
      ],
    ),
    style: DsfrTextStyle.bodySm(),
  );
}

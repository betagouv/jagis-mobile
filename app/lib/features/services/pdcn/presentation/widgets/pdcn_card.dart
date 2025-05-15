// ignore_for_file: prefer-single-widget-per-file

import 'package:app/core/assets/images.dart';
import 'package:app/core/helpers/size.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/pdcn/domain/pdcn_summary.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/pages/pdcn_detail_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class PdcnCard extends StatelessWidget {
  const PdcnCard({super.key, required this.e});

  final PdcnSummary e;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(PdcnDetailPage.name, pathParameters: {'id': e.id});
    },
    child: SizedBox(
      width: screenWidth(context, percentage: 0.7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Text(e.name, style: const DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50)),
                  Text(
                    e.address,
                    style: const DsfrTextStyle.bodyXs(color: DsfrColors.grey50),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const Spacer(),
                  DsfrTag(
                    label: Localisation.distance(e.distanceInMeters),
                    size: DsfrComponentSize.sm,
                    backgroundColor: const Color(0xffEAEAEA),
                    textColor: const Color(0xff3F3F3F),
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

import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ThemeServiceInfo extends StatelessWidget {
  const ThemeServiceInfo({super.key, required this.link});

  final ThemeSummaryInternalLink link;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(link.route, pathParameters: link.pathParameters ?? const {});
    },
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s3v,
        top: DsfrSpacings.s3v,
        right: DsfrSpacings.s1w,
        bottom: DsfrSpacings.s3v,
      ),
      child: Row(
        spacing: DsfrSpacings.s1v,
        children: [
          Expanded(child: FnvMarkdown(data: link.label)),
          const Icon(DsfrIcons.systemArrowRightSLine, size: 20, color: DsfrColors.blueFranceSun113),
        ],
      ),
    ),
  );
}

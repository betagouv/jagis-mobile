import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThemeServiceInfo extends StatelessWidget {
  const ThemeServiceInfo({super.key, required this.link});

  final ThemeSummaryInternalLink link;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(link.route, pathParameters: link.pathParams ?? const {});
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 8, bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1v,
        children: [
          Flexible(child: FnvMarkdown(data: link.label)),
          const Icon(DsfrIcons.systemArrowRightSLine, size: 20, color: DsfrColors.blueFranceSun113),
        ],
      ),
    ),
  );
}

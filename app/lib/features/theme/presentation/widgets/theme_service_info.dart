import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThemeServiceInfo extends StatelessWidget {
  const ThemeServiceInfo({super.key, required this.link});

  final ThemeSummaryLink link;

  @override
  Widget build(final context) => FnvCard(
    onTap: () async {
      final aLink = link;
      switch (aLink) {
        case ThemeSummaryInternalLink():
          await GoRouter.of(context).pushNamed(aLink.route);
        case ThemeSummaryExternalLink():
          await FnvUrlLauncher.launch(aLink.url);
      }
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 8, top: 12, right: 4, bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsfrSpacings.s1v,
        children: [
          Flexible(child: FnvMarkdown(data: link.label, p: const DsfrTextStyle.bodySm())),
          Icon(
            switch (link) {
              ThemeSummaryInternalLink() => DsfrIcons.systemArrowRightSLine,
              ThemeSummaryExternalLink() => DsfrIcons.systemExternalLinkLine,
            },
            size: 20,
            color: DsfrColors.blueFranceSun113,
          ),
        ],
      ),
    ),
  );
}

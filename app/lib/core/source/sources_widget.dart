import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/source/source.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class SourcesWidget extends StatelessWidget {
  const SourcesWidget({super.key, required this.sources});

  final List<Source> sources;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(Localisation.sources, style: DsfrTextStyle.bodySmBold(color: DsfrColors.grey50)),
      const SizedBox(height: DsfrSpacings.s1w),
      ...sources.map(
        (final source) => Padding(
          padding: const EdgeInsets.only(bottom: DsfrSpacings.s1w),
          child: Row(
            children: [
              const Text('• '),
              Flexible(
                child: DsfrLink(
                  label: source.label,
                  iconPosition: DsfrLinkIconPosition.end,
                  icon: DsfrIcons.systemExternalLinkLine,
                  onTap: () async {
                    await FnvUrlLauncher.launch(source.url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

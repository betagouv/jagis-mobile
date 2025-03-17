import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionMarkdown extends StatelessWidget {
  const ActionMarkdown({super.key, required this.data});

  final String data;

  @override
  Widget build(final context) => FnvMarkdown(
    data: data.replaceAll(' ?', ' ?').replaceAll(' !', ' !'),
    h1: const DsfrTextStyle(fontSize: 22),
    h2: const DsfrTextStyle(fontSize: 20),
    h3: const DsfrTextStyle(fontSize: 18),
    p: const DsfrTextStyle(fontSize: 16),
    a: const DsfrTextStyle(fontSize: 16, color: DsfrColors.blueFranceSun113),
    onTapLink: (final href) async {
      if (href != null) {
        await FnvUrlLauncher.launch(href);
      }
    },
    imageBuilder: (final uri, final alt) => FnvImage.network(uri.toString(), semanticLabel: alt),
  );
}

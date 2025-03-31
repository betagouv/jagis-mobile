import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/custom_widgets/markdown_config.dart';

@immutable
class ActionMarkdownHeading extends FNVHTag {
  ActionMarkdownHeading({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(final BuildContext context, final String text, final GptMarkdownConfig config) {
    final match = exp.firstMatch(text.trim());
    final namedGroup = match?.namedGroup('data');
    if (namedGroup == null) {
      return const SizedBox.shrink();
    }
    final headingLvl = match![1]!.length;

    if (headingLvl >= 3) {
      return super.build(context, text, config);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: DsfrSpacings.s1w),
      child: Row(
        spacing: DsfrSpacings.s1w,
        children: [
          Icon(icon, size: 30, color: color),
          Expanded(child: Text(namedGroup.replaceAll(RegExp(r'#+$'), ''), style: const DsfrTextStyle.headline3())),
        ],
      ),
    );
  }
}

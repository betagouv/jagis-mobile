import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/custom_widgets/markdown_config.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

@immutable
class ActionMarkdownHeading extends FNVHTag {
  ActionMarkdownHeading({required this.icon, required this.iconColor});

  final IconData icon;
  final Color iconColor;

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

    final theme = GptMarkdownTheme.of(context);
    const dsfrTextStyle = DsfrTextStyle.headline3();
    final conf = config.copyWith(
      style: [
        dsfrTextStyle,
        dsfrTextStyle,
        theme.h3,
        theme.h4,
        theme.h5,
        theme.h6,
      ][match[1]!.length - 1]?.copyWith(color: config.style?.color),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: DsfrSpacings.s1w),
      child: Row(
        spacing: DsfrSpacings.s1w,
        children: [
          Icon(icon, size: 30, color: iconColor),
          Expanded(
            child: Text.rich(
              TextSpan(children: MarkdownComponent.generate(context, namedGroup.replaceAll(RegExp(r'#+$'), ''), conf, false)),
            ),
          ),
        ],
      ),
    );
  }
}

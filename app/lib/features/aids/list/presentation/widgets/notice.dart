import 'package:app/core/infrastructure/markdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:gpt_markdown/custom_widgets/markdown_config.dart' show GptMarkdownConfig;
import 'package:gpt_markdown/gpt_markdown.dart';

class FnvNotice extends StatelessWidget {
  const FnvNotice({
    super.key,
    required this.titre,
    required this.description,
    this.type = DsfrNoticeType.genericInfo,
    required this.onClose,
  });

  final String titre;
  final String description;
  final DsfrNoticeType type;
  final VoidCallback? onClose;

  IconData _getIcon() => switch (type) {
    DsfrNoticeType.genericInfo => DsfrIcons.systemFrInfoFill,
    DsfrNoticeType.genericAlert => DsfrIcons.systemErrorWarningFill,
    DsfrNoticeType.weatherOrange => DsfrIcons.weatherHeavyShowersFill,
    DsfrNoticeType.weatherRed => DsfrIcons.weatherTornadoFill,
    DsfrNoticeType.weatherPurple => DsfrIcons.weatherTyphoonFill,
    DsfrNoticeType.alertAttack => DsfrIcons.systemFrAlertWarning2Fill,
    DsfrNoticeType.genericWarning ||
    DsfrNoticeType.alertCallForWitnesses ||
    DsfrNoticeType.alertTechnology => DsfrIcons.systemFrWarningFill,
  };

  Color _getBackgroundColor(final BuildContext context) => switch (type) {
    DsfrNoticeType.genericInfo => DsfrColorDecisions.backgroundContrastInfo(context),
    DsfrNoticeType.genericAlert => DsfrColorDecisions.backgroundContrastError(context),
    DsfrNoticeType.weatherPurple => DsfrColorDecisionsExtension.backgroundPurpleGlycineLow(context),
    DsfrNoticeType.genericWarning || DsfrNoticeType.weatherOrange => DsfrColorDecisions.backgroundContrastWarning(context),
    DsfrNoticeType.weatherRed || DsfrNoticeType.alertAttack => DsfrColorDecisions.backgroundFlatError(context),
    DsfrNoticeType.alertCallForWitnesses || DsfrNoticeType.alertTechnology => DsfrColorDecisions.backgroundFlatGrey(context),
  };

  Color _getTextColor(final BuildContext context) => switch (type) {
    DsfrNoticeType.genericInfo => DsfrColorDecisions.textDefaultInfo(context),
    DsfrNoticeType.genericWarning => DsfrColorDecisions.textDefaultWarning(context),
    DsfrNoticeType.genericAlert => DsfrColorDecisions.textActionHighError(context),
    DsfrNoticeType.weatherOrange => DsfrColorDecisions.textActionHighWarning(context),
    DsfrNoticeType.weatherRed ||
    DsfrNoticeType.weatherPurple ||
    DsfrNoticeType.alertAttack ||
    DsfrNoticeType.alertCallForWitnesses ||
    DsfrNoticeType.alertTechnology => DsfrColorDecisions.textInvertedGrey(context),
  };

  bool _isAlertType() =>
      type == DsfrNoticeType.alertAttack ||
      type == DsfrNoticeType.alertCallForWitnesses ||
      type == DsfrNoticeType.alertTechnology;

  Color _getLineColor(final BuildContext context) => switch (type) {
    DsfrNoticeType.alertAttack => DsfrColorDecisions.borderPlainGrey(context),
    DsfrNoticeType.alertCallForWitnesses => DsfrColorDecisions.borderPlainError(context),
    DsfrNoticeType.alertTechnology => DsfrColorDecisions.borderPlainInfo(context),
    DsfrNoticeType.genericInfo ||
    DsfrNoticeType.genericWarning ||
    DsfrNoticeType.genericAlert ||
    DsfrNoticeType.weatherOrange ||
    DsfrNoticeType.weatherRed ||
    DsfrNoticeType.weatherPurple => DsfrColorDecisions.backgroundTransparent(context),
  };

  @override
  Widget build(final context) {
    final color = _getTextColor(context);
    final textStyle = DsfrTextStyle.bodySm(color: color);

    return Column(
      children: [
        if (_isAlertType()) Divider(height: 0, thickness: 6, color: _getLineColor(context)) else const SizedBox.shrink(),
        ColoredBox(
          color: _getBackgroundColor(context),
          child: Padding(
            padding: const EdgeInsets.only(left: DsfrSpacings.s2w, bottom: DsfrSpacings.s2w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: DsfrSpacings.s3v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: DsfrSpacings.s1w,
                          children: [
                            Icon(_getIcon(), color: color),
                            Expanded(
                              child: Text(titre, style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        FnvMarkdown(data: description, p: textStyle, aTag: _ATagMd()),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  iconSize: DsfrSpacings.s2w,
                  onPressed: onClose,
                  icon: Icon(DsfrIcons.systemCloseLine, color: color, semanticLabel: 'Masquer le message'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ATagMd extends ATagMd {
  @override
  RegExp get exp => RegExp(r'\[([^\[\]]*)\]\(([^\s]*)\)');

  @override
  InlineSpan span(final BuildContext context, final String text, final GptMarkdownConfig config) {
    final match = exp.firstMatch(text.trim());
    if (match?[1] == null && match?[2] == null) {
      return const TextSpan();
    }

    final linkText = match?[1] ?? '';
    final url = match?[2] ?? '';

    final recognizer = TapGestureRecognizer()..onTap = () => config.onLinkTap?.call(url, linkText);

    return TextSpan(
      text: linkText,
      style: config.style?.copyWith(decoration: TextDecoration.underline, decorationColor: config.style?.color),
      recognizer: recognizer,
    );
  }
}

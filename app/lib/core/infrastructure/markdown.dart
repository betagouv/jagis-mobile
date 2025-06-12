import 'package:app/core/infrastructure/image_viewer.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:gpt_markdown/custom_widgets/markdown_config.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class FnvMarkdown extends StatelessWidget {
  const FnvMarkdown({
    super.key,
    required this.data,
    this.h1 = const DsfrTextStyle.headline4(color: DsfrColors.grey50),
    this.h2 = const DsfrTextStyle.headline4(color: DsfrColors.grey50),
    this.h3 = const DsfrTextStyle.headline5(color: DsfrColors.grey50),
    this.p = const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
    this.strong,
    this.hTag,
    this.overflow,
  });

  final String data;
  final TextStyle? h1;
  final TextStyle? h2;
  final TextStyle? h3;
  final TextStyle? p;
  final TextStyle? strong;
  final HTag? hTag;
  final TextOverflow? overflow;

  @override
  Widget build(final BuildContext context) => GptMarkdownTheme(
    gptThemeData: GptMarkdownThemeData(brightness: Brightness.light, h1: h1, h2: h2, h3: h3),
    child: GptMarkdown(
      data.replaceAll(' ?', ' ?').replaceAll(' !', ' !').replaceAll(' :', ' :'),
      style: p,
      onLinkTab: (final url, final title) async {
        await FnvUrlLauncher.launch(url);
      },
      overflow: overflow,
      components: [
        CodeBlockMd(),
        NewLines(),
        BlockQuote(),
        _ImageMd(),
        _ATagMd(),
        TableMd(),
        hTag ?? FNVHTag(),
        UnOrderedList(),
        OrderedList(),
        RadioButtonMd(),
        CheckBoxMd(),
        HrLine(),
        StrikeMd(),
        _BoldMd(strong),
        ItalicMd(),
        LatexMath(),
        LatexMathMultiLine(),
        HighlightedText(),
        SourceTag(),
        IndentMd(),
      ],
    ),
  );
}

class FNVHTag extends HTag {
  @override
  Widget build(final BuildContext context, final String text, final GptMarkdownConfig config) {
    final match = exp.firstMatch(text.trim());
    final namedGroup = match?.namedGroup('data');
    if (namedGroup == null) {
      return const SizedBox.shrink();
    }

    final theme = GptMarkdownTheme.of(context);
    final conf = config.copyWith(
      style: [
        theme.h1,
        theme.h2,
        theme.h3,
        theme.h4,
        theme.h5,
        theme.h6,
      ][match![1]!.length - 1]?.copyWith(color: config.style?.color),
    );

    return Padding(
      padding: const EdgeInsets.only(top: DsfrSpacings.s2w, bottom: DsfrSpacings.s1w),
      child: Text.rich(TextSpan(children: MarkdownComponent.generate(context, namedGroup, conf, false))),
    );
  }
}

class _BoldMd extends BoldMd {
  _BoldMd(this.textStyle);

  final TextStyle? textStyle;

  @override
  InlineSpan span(final BuildContext context, final String text, final GptMarkdownConfig config) {
    final match = exp.firstMatch(text.trim());
    final boldText = match?[1];
    if (boldText == null) {
      return const TextSpan();
    }

    final conf = config.copyWith(
      style: textStyle ?? config.style?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle(fontWeight: FontWeight.bold),
    );

    return TextSpan(style: conf.style, children: MarkdownComponent.generate(context, boldText, conf, false));
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

    return WidgetSpan(
      child: DsfrLink(
        label: linkText,
        onTap: () {
          config.onLinkTab?.call(url, linkText);
        },
      ),
    );
  }
}

class _ImageMd extends ImageMd {
  @override
  RegExp get exp => RegExp(r'\!\[([^\[\]]*)\]\(([^\s]*)\)');

  @override
  InlineSpan span(final BuildContext context, final String text, final GptMarkdownConfig config) {
    final match = exp.firstMatch(text.trim());
    if (match == null) {
      return const TextSpan();
    }
    final imageUrl = match[2];

    if (imageUrl == null) {
      return const TextSpan();
    }

    final altText = match[1];

    return WidgetSpan(
      child: GestureDetector(
        onTap: () async {
          await enlargeImage(context, src: imageUrl, semanticLabel: altText);
        },
        child: FnvImage.network(imageUrl, semanticLabel: altText),
      ),
    );
  }
}

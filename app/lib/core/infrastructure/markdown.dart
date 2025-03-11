import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

typedef FnvMarkdownLinkTapCallback = void Function(String? href);
typedef FnvMarkdownImageBuilder = Widget Function(Uri uri, String? alt);

class FnvMarkdown extends StatelessWidget {
  const FnvMarkdown({super.key, required this.data, this.h1, this.p, this.a, this.strong, this.onTapLink, this.imageBuilder});

  final String data;
  final TextStyle? h1;
  final TextStyle? p;
  final TextStyle? a;
  final TextStyle? strong;
  final FnvMarkdownLinkTapCallback? onTapLink;
  final FnvMarkdownImageBuilder? imageBuilder;

  @override
  Widget build(final BuildContext context) => MarkdownBody(
    data: data,
    styleSheet: MarkdownStyleSheet(a: a, p: p, h1: h1, strong: strong),
    onTapLink: onTapLink == null ? null : (final text, final href, final title) => onTapLink!(href),
    imageBuilder: imageBuilder == null ? null : (final uri, final title, final alt) => imageBuilder!(uri, alt),
  );
}

({String content, String heading}) parseFirstHeadingInMardown(final String markdownString) {
  final titleRegex = RegExp(r'^#+\s+(.+)\s*\n');
  final titleMatch = titleRegex.firstMatch(markdownString);
  final heading = titleMatch == null ? '' : titleMatch.group(1)!.trim();

  final content = markdownString.trim().replaceAll(RegExp(r'^#+\s+(.+)\s*\n'), '').trim();

  return (heading: heading, content: content);
}

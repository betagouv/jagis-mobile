import 'package:flutter_test/flutter_test.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

/// Iel voit le texte Markdown.
void ielVoitLeTexteMarkdown(final WidgetTester tester, final String texte) {
  final markdownBody = tester.widget<GptMarkdown>(find.byType(GptMarkdown).first);
  expect(markdownBody.data, texte);
}

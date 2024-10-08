import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QuestionSection extends StatelessWidget {
  const QuestionSection({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n.uneQuestion,
              style: DsfrTextStyle.headline4(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          DsfrAccordionsGroup(
            values: [
              DsfrAccordion(
                headerBuilder: (final isExpanded) => const _AccordionHeader(
                  text: EnvironmentalPerformanceSummaryL10n.quEstCeQuUn,
                ),
                body: _AccordionBody(
                  child: MarkdownBody(
                    data:
                        EnvironmentalPerformanceSummaryL10n.quEstCeQuUnContenu,
                    styleSheet: MarkdownStyleSheet(
                      p: const DsfrTextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              DsfrAccordion(
                headerBuilder: (final isExpanded) => const _AccordionHeader(
                  text: EnvironmentalPerformanceSummaryL10n.commentEstCalcule,
                ),
                body: _AccordionBody(
                  child: MarkdownBody(
                    data: EnvironmentalPerformanceSummaryL10n
                        .commentEstCalculeContenu,
                    styleSheet: MarkdownStyleSheet(
                      a: const DsfrTextStyle(
                        fontSize: 15,
                        color: DsfrColors.blueFranceSun113,
                      ),
                      p: const DsfrTextStyle(fontSize: 15),
                    ),
                    onTapLink: (final text, final href, final title) async {
                      if (href == null) {
                        return;
                      }
                      await launchUrlString(href);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

class _AccordionHeader extends StatelessWidget {
  const _AccordionHeader({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text(
          text,
          style: const DsfrTextStyle.bodyMdMedium(
            color: DsfrColors.blueFranceSun113,
          ),
        ),
      );
}

class _AccordionBody extends StatelessWidget {
  const _AccordionBody({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(paddingVerticalPage),
        child: child,
      );
}

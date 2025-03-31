import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class QuestionSection extends StatelessWidget {
  const QuestionSection({super.key});

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s3v,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Text(EnvironmentalPerformanceSummaryL10n.uneQuestion, style: DsfrTextStyle.headline4()),
      ),
      DsfrAccordionsGroup(
        values: [
          const DsfrAccordion.simple(
            label: EnvironmentalPerformanceSummaryL10n.quEstCeQuUn,
            body: _AccordionBody(
              child: FnvMarkdown(data: EnvironmentalPerformanceSummaryL10n.quEstCeQuUnContenu, p: DsfrTextStyle(fontSize: 15)),
            ),
          ),
          DsfrAccordion.simple(
            label: EnvironmentalPerformanceSummaryL10n.commentEstCalcule,
            body: _AccordionBody(
              // TODO(erolley): factorize markdown body in Accordion
              child: FnvMarkdown(
                data: EnvironmentalPerformanceSummaryL10n.commentEstCalculeContenu,
                p: const DsfrTextStyle(fontSize: 15),
                a: const DsfrTextStyle(fontSize: 15, color: DsfrColors.blueFranceSun113),
                onTapLink: (final href) async {
                  if (href == null) {
                    return;
                  }
                  await FnvUrlLauncher.launch(href);
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

class _AccordionBody extends StatelessWidget {
  const _AccordionBody({required this.child});

  final Widget child;

  @override
  Widget build(final context) => Padding(padding: const EdgeInsets.all(paddingVerticalPage), child: child);
}

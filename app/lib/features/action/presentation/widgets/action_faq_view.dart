import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/faq/domain/faq.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionFAQView extends StatelessWidget {
  const ActionFAQView({super.key, required this.faq});

  final List<FAQItem> faq;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const Text(Localisation.onRepondAVosQuestions, style: DsfrTextStyle.headline3()),
        DsfrAccordionsGroup(
          values:
              faq
                  .map(
                    (final faqItem) => DsfrAccordion.simple(
                      label: faqItem.question,
                      body: FnvMarkdown(data: faqItem.answer, p: const DsfrTextStyle.bodyMd()),
                    ),
                  )
                  .toList(),
        ),
      ],
    ),
  );
}

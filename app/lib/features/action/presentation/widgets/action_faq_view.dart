import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action_ask_question/presentation/pages/action_ask_question_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ActionFAQView extends StatelessWidget {
  const ActionFAQView({super.key, required this.action});

  final Action action;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const Text(Localisation.onRepondAVosQuestions, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
      DsfrAccordionsGroup(
        values: action.faq!
            .map(
              (final faqItem) => DsfrAccordion(
                headerLabel: faqItem.question,
                body: FnvMarkdown(data: faqItem.answer),
              ),
            )
            .toList(),
      ),
      Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: DsfrLink(
                label: Localisation.posezVotreQuestion,
                onTap: () async {
                  await GoRouter.of(context).pushNamed(
                    ActionAskQuestionPage.name,
                    pathParameters: ActionAskQuestionPage.pathParameters(type: action.type, title: action.title, id: action.id),
                  );
                },
              ),
            ),
            const TextSpan(text: Localisation.notreEquipeVousRepond),
          ],
        ),
        style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
      ),
    ],
  );
}

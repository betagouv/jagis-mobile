import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/domain/response_mosaic.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/my_answers/detail/presentation/widgets/mosaic_button.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class Mosaic extends StatelessWidget {
  const Mosaic({super.key, required this.question});

  final AnswersMosaicBoolean question;

  @override
  Widget build(final BuildContext context) => _MosaicSet(question: question);
}

class _MosaicSet extends StatefulWidget {
  const _MosaicSet({required this.question});

  final AnswersMosaicBoolean question;

  @override
  State<_MosaicSet> createState() => _MosaicSetState();
}

class _MosaicSetState extends State<_MosaicSet> {
  List<ResponseMosaic> _responses = [];

  @override
  void initState() {
    super.initState();
    _responses = List.of(widget.question.responses);
  }

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: DsfrSpacings.s2w,
          crossAxisSpacing: DsfrSpacings.s2w,
        ),
        itemBuilder: (final context, final index) {
          final item = _responses[index];

          return MosaicButton(
            emoji: item.emoji,
            title: item.label,
            value: item.isSelected,
            onChanged: (final value) {
              setState(() {
                _responses = _responses
                    .map(
                      (final r) => r.code == item.code
                          ? ResponseMosaic(code: r.code, label: r.label, emoji: r.emoji, isSelected: value)
                          : r,
                    )
                    .toList();
              });
              context.read<QuestionEditBloc>().add(
                QuestionEditAnswersChanged(
                  widget.question.changeResponses(_responses.where((final f) => f.isSelected).map((final f) => f.label).toList()),
                ),
              );
            },
          );
        },
        itemCount: _responses.length,
      ),
      DsfrLink(
        label: Localisation.aucuneDeCesPropositions,
        onTap: () => context.read<QuestionEditBloc>().add(const QuestionEditMosaicAucuneProposition()),
      ),
    ],
  );
}

import 'package:app/core/question/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixUnique extends StatelessWidget {
  const ChoixUnique({super.key, required this.question});

  final QuestionSingleChoice question;

  @override
  Widget build(final BuildContext context) => DsfrRadioButtonGroupHeadless(
    mode: DsfrRadioButtonSetMode.column,
    values: Map.fromEntries(question.responses.map((final r) => MapEntry(r.label, r.label))),
    onChanged: (final value) {
      if (value == null) {
        return;
      }
      context.read<QuestionEditBloc>().add(QuestionEditChoixUniqueChangee(value));
    },
    initialValue: question.responses.where((final r) => r.isSelected).firstOrNull?.label,
  );
}

import 'package:app/core/question/domain/question.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/my_answers/detail/presentation/bloc/question_edit_event.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ChoixUnique extends StatelessWidget {
  const ChoixUnique({super.key, required this.question});

  final QuestionSingleChoice question;

  @override
  Widget build(final BuildContext context) => FnvRadiosGroup(
    values: Map.fromEntries(question.responses.map((final r) => MapEntry(r.code, r.label))),
    initialValue: question.responses.where((final r) => r.isSelected).firstOrNull?.code,
    onChanged: (final value) {
      if (value == null) {
        return;
      }
      context.read<QuestionEditBloc>().add(QuestionEditChoixUniqueChangee(value));
    },
    direction: Direction.vertical,
    size: DsfrComponentSize.md,
  );
}

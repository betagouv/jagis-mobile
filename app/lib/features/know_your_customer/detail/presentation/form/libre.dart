import 'package:app/core/question/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class Libre extends StatelessWidget {
  const Libre({super.key, required this.question});

  final QuestionOpen question;

  @override
  Widget build(final BuildContext context) {
    final controller = TextEditingController(text: question.response.value);

    return DsfrInputHeadless(
      key: const ValueKey(Localisation.maReponse),
      controller: controller,
      onChanged: (final value) => context.read<QuestionEditBloc>().add(QuestionEditLibreChangee(value)),
      maxLines: 4,
    );
  }
}

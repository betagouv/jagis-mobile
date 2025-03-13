import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_state.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_multiple.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_unique.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/decimal.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/entier.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/libre.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mosaic.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Callback = void Function();

class QuestionForm extends StatelessWidget {
  const QuestionForm({
    super.key,
    required this.questionId,
    this.withoutTitle = false,
    required this.questionController,
    this.inputController,
    this.onSaved,
  });

  final String questionId;
  final bool withoutTitle;
  final QuestionController questionController;
  final InputController? inputController;
  final Callback? onSaved;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            QuestionEditBloc(questionRepository: context.read())..add(QuestionEditRecuperationDemandee(questionId)),
    lazy: false,
    child: _Content(
      withoutTitle: withoutTitle,
      questionController: questionController,
      inputController: inputController,
      onSaved: onSaved,
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.withoutTitle,
    required this.questionController,
    required this.inputController,
    required this.onSaved,
  });

  final bool withoutTitle;
  final QuestionController questionController;
  final InputController? inputController;
  final Callback? onSaved;

  @override
  Widget build(final context) => BlocListener<QuestionEditBloc, QuestionEditState>(
    listener: (final context, final state) {
      final aState = state;

      if (aState is QuestionEditLoaded) {
        print('aState: ${aState.question.responsesDisplay()}');
        print('newState: ${aState.newQuestion.responsesDisplay()}');
      }

      if (aState is QuestionEditLoaded && aState.newQuestion.responsesDisplay().isNotEmpty) {
        inputController?.edited();
      }

      if (aState is QuestionEditLoaded && aState.updated) {
        onSaved?.call();
      }
    },
    child: BlocBuilder<QuestionEditBloc, QuestionEditState>(
      builder:
          (final context, final state) => switch (state) {
            QuestionEditInitial() => const SizedBox(height: 550),
            QuestionEditLoaded() => _LoadedContent(withoutTitle: withoutTitle, controller: questionController, state: state),
            QuestionEditError() => FnvFailureWidget(
              onPressed: () => context.read<QuestionEditBloc>().add(QuestionEditRecuperationDemandee(state.id)),
            ),
          },
      buildWhen:
          (final oldState, final newState) =>
              (oldState is! QuestionEditLoaded || newState is! QuestionEditLoaded) || oldState.question != newState.question,
    ),
  );
}

class _LoadedContent extends StatefulWidget {
  const _LoadedContent({required this.withoutTitle, required this.controller, required this.state});

  final bool withoutTitle;
  final QuestionEditLoaded state;
  final QuestionController controller;

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() => context.read<QuestionEditBloc>().add(QuestionEditMisAJourDemandee(widget.state.question.code.value));

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final context) {
    final question = widget.state.question;

    print('input build newQuestion: ${widget.state.newQuestion.responsesDisplay()}');

    return Column(
      spacing: DsfrSpacings.s3w,
      children: [
        if (!widget.withoutTitle)
          FnvTitle(
            title: question.label,
            subtitle: switch (question) {
              QuestionMultipleChoice() || QuestionMosaicBoolean() => Localisation.plusieursReponsesPossibles,
              QuestionSingleChoice() || QuestionInteger() || QuestionDecimal() || QuestionOpen() => null,
            },
          ),
        switch (question) {
          QuestionSingleChoice() => ChoixUnique(question: question),
          QuestionMultipleChoice() => ChoixMultiple(question: question),
          QuestionInteger() => Entier(question: question),
          QuestionDecimal() => Decimal(question: question),
          QuestionOpen() => Libre(question: question),
          QuestionMosaicBoolean() => Mosaic(question: question),
        },
      ],
    );
  }
}

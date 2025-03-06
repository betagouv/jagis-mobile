import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_multiple.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_unique.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/decimal.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/entier.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/libre.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mosaic.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnSavedCallback = void Function();

class MieuxVousConnaitreForm extends StatelessWidget {
  const MieuxVousConnaitreForm({
    super.key,
    required this.questionId,
    this.withoutTitle = false,
    required this.controller,
    this.onSaved,
  });

  final String questionId;
  final bool withoutTitle;
  final MieuxVousConnaitreController controller;
  final OnSavedCallback? onSaved;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            MieuxVousConnaitreEditBloc(mieuxVousConnaitreRepository: context.read())
              ..add(MieuxVousConnaitreEditRecuperationDemandee(questionId)),
    lazy: false,
    child: _Content(withoutTitle: withoutTitle, controller: controller, onSaved: onSaved),
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.withoutTitle, required this.controller, required this.onSaved});

  final bool withoutTitle;
  final MieuxVousConnaitreController controller;
  final OnSavedCallback? onSaved;

  @override
  Widget build(final context) => BlocListener<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
    listener: (final context, final state) {
      final aState = state;
      if (aState is MieuxVousConnaitreEditLoaded && aState.updated) {
        onSaved?.call();
      }
    },
    child: BlocBuilder<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
      builder:
          (final context, final state) => switch (state) {
            MieuxVousConnaitreEditInitial() => const SizedBox(height: 550),
            MieuxVousConnaitreEditLoaded() => _LoadedContent(withoutTitle: withoutTitle, controller: controller, state: state),
            MieuxVousConnaitreEditError() => FnvFailureWidget(
              onPressed:
                  () => context.read<MieuxVousConnaitreEditBloc>().add(MieuxVousConnaitreEditRecuperationDemandee(state.id)),
            ),
          },
      buildWhen:
          (final oldState, final newState) =>
              (oldState is! MieuxVousConnaitreEditLoaded || newState is! MieuxVousConnaitreEditLoaded) ||
              oldState.question != newState.question,
    ),
  );
}

class _LoadedContent extends StatefulWidget {
  const _LoadedContent({required this.withoutTitle, required this.controller, required this.state});

  final bool withoutTitle;
  final MieuxVousConnaitreEditLoaded state;
  final MieuxVousConnaitreController controller;

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() =>
      context.read<MieuxVousConnaitreEditBloc>().add(MieuxVousConnaitreEditMisAJourDemandee(widget.state.question.code.value));

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final context) {
    final question = widget.state.question;

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

import 'package:app/features/car_simulator/infrastructure/car_simulator_questions_manager.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorWidget extends StatelessWidget {
  const CarSimulatorWidget({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) =>
            QuestionsManagerBloc(application: CarSimulatorQuestionsManager(client: context.read()))
              ..add(const QuestionsManagerFirstQuestionRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => BlocBuilder<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _Success(questionManager: state),
        },
  );
}

class _Success extends StatefulWidget {
  const _Success({required this.questionManager});

  final QuestionsManagerLoadSuccess questionManager;

  @override
  State<_Success> createState() => _SuccessState();
}

class _SuccessState extends State<_Success> {
  final _controller = MieuxVousConnaitreController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) =>
      widget.questionManager.cursor.allQuestionsAreAnswered
          ? const CarSimulatorResult()
          : Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              spacing: DsfrSpacings.s1w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO(erolley): to factorize and extract in its own widget
                Text.rich(
                  TextSpan(
                    text: 'Question ',
                    style: const DsfrTextStyle.bodyLg(color: DsfrColors.blueFranceSun113),
                    children: [
                      TextSpan(
                        text: (widget.questionManager.cursor.index + 1).toString(),
                        style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113),
                      ),
                      const TextSpan(text: ' sur ', style: DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113)),
                      TextSpan(
                        text: widget.questionManager.cursor.total.toString(),
                        style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113),
                      ),
                    ],
                  ),
                ),
                MieuxVousConnaitreForm(
                  questionId: widget.questionManager.cursor.element!.id.value,
                  controller: _controller,
                  onSaved: () {
                    context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  spacing: DsfrSpacings.s1w,
                  children: [
                    DsfrButtonIcon(
                      variant: DsfrButtonVariant.secondary,
                      icon: DsfrIcons.systemArrowLeftLine,
                      size: DsfrButtonSize.lg,
                      onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
                    ),
                    DsfrButton(
                      label: Localisation.questionSuivante,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.lg,
                      onPressed: _controller.save,
                    ),
                  ],
                ),
              ],
            ),
          );
}

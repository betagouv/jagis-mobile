import 'package:app/features/car_simulator/infrastructure/car_simulator_questions_manager.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
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
          QuestionsManagerLoadSuccess() => _Success(aState: state),
        },
  );
}

class _Success extends StatefulWidget {
  const _Success({required this.aState});

  final QuestionsManagerLoadSuccess aState;

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
      widget.aState.cursor.allQuestionsAreAnswered
          ? const CarSimulatorResult()
          : Column(
            children: [
              MieuxVousConnaitreForm(
                questionId: widget.aState.cursor.current!.id.value,
                controller: _controller,
                onSaved: () {
                  context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
                },
              ),
              const SizedBox(height: 16),
              DsfrButton(
                label: 'Suivant',
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: _controller.save,
              ),
              DsfrButton(
                label: 'Précédent',
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
              ),
            ],
          );
}

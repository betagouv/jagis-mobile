import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/action_ask_question/presentation/bloc/action_ask_question_bloc.dart';
import 'package:app/features/action_ask_question/presentation/bloc/action_ask_question_event.dart';
import 'package:app/features/action_ask_question/presentation/bloc/action_ask_question_state.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionAskQuestionPage extends StatelessWidget {
  const ActionAskQuestionPage({super.key, required this.type, required this.id});

  static const name = 'action-ask-question';
  static const path = 'action/:type/:title/:id/ask-question';

  static Map<String, String> pathParameters({
    required final ActionType type,
    required final String title,
    required final String id,
  }) => {'type': actionTypeToAPIString(type), 'title': title, 'id': id};

  final ActionType type;
  final String id;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) =>
        ActionAskQuestionPage(type: actionTypeFromAPIString(state.pathParameters['type']!), id: state.pathParameters['id']!),
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => ActionAskQuestionBloc(context.read(), type: type, id: id),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocListener<ActionAskQuestionBloc, ActionAskQuestionState>(
      listener: (final context, final state) {
        if (state.isSend) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text(Localisation.posezVotreQuestionSnackBar), showCloseIcon: true));
          GoRouter.of(context).pop(true);
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(
          left: DsfrSpacings.s2w,
          top: DsfrSpacings.s2w,
          right: DsfrSpacings.s2w,
          bottom: DsfrSpacings.s4w,
        ),
        children: [
          const Text(Localisation.posezVotreQuestion, style: DsfrTextStyle.headline3()),
          const SizedBox(height: DsfrSpacings.s2w),
          const Align(alignment: Alignment.centerLeft, child: FnvImage.asset(AssetImages.askQuestion, width: 156, height: 156)),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.posezVotreQuestionDescription, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey200)),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrInputHeadless(
            key: const ValueKey(Localisation.posezVotreQuestion),
            onChanged: (final value) => context.read<ActionAskQuestionBloc>().add(ActionAskQuestionMessageChanged(value)),
            maxLines: 6,
            maxLength: 500,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: BlocBuilder<ActionAskQuestionBloc, ActionAskQuestionState>(
                builder: (final context, final state) => DsfrButton(
                  label: Localisation.envoyer,
                  icon: DsfrIcons.systemArrowRightSLine,
                  iconLocation: DsfrButtonIconLocation.right,
                  variant: DsfrButtonVariant.secondary,
                  size: DsfrComponentSize.lg,
                  onPressed: state.message.isNotEmpty
                      ? () => context.read<ActionAskQuestionBloc>().add(const ActionAskQuestionSendRequested())
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

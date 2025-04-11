import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/action_feedback/presentation/bloc/action_feedback_bloc.dart';
import 'package:app/features/action_feedback/presentation/bloc/action_feedback_event.dart';
import 'package:app/features/action_feedback/presentation/bloc/action_feedback_state.dart';
import 'package:app/features/action_feedback/presentation/widgets/feedback_stars.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionFeedbackPage extends StatelessWidget {
  const ActionFeedbackPage({super.key, required this.type, required this.id, required this.rate});

  static const name = 'action-feedback';
  static const path = 'action/:type/:title/:id/feedback/:rate';

  static Map<String, String> pathParameters({
    required final ActionType type,
    required final String title,
    required final String id,
    required final int rate,
  }) => {'type': actionTypeToAPIString(type), 'title': title, 'id': id, 'rate': rate.toString()};

  final ActionType type;
  final String id;
  final int rate;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder:
        (final context, final state) => ActionFeedbackPage(
          type: actionTypeFromAPIString(state.pathParameters['type']!),
          id: state.pathParameters['id']!,
          rate: int.parse(state.pathParameters['rate']!),
        ),
  );

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => ActionFeedbackBloc(context.read(), type: type, id: id, rate: rate),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocConsumer<ActionFeedbackBloc, ActionFeedbackState>(
      builder:
          (final context, final state) => ListView(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s2w,
              top: DsfrSpacings.s2w,
              right: DsfrSpacings.s2w,
              bottom: DsfrSpacings.s4w,
            ),

            children: [
              const Text(Localisation.avezVousAimeCettePage, style: DsfrTextStyle.headline3()),
              const SizedBox(height: DsfrSpacings.s2w),
              const Align(alignment: Alignment.centerLeft, child: FnvImage.asset(AssetImages.feedback, width: 156, height: 156)),
              const SizedBox(height: DsfrSpacings.s1w),
              const Text(Localisation.avezVousAimeCettePageDescription, style: DsfrTextStyle.bodyMd(color: DsfrColors.grey200)),
              const SizedBox(height: DsfrSpacings.s3w),
              const Text(Localisation.avezVousAimeCettePage, style: DsfrTextStyle.bodyMd()),
              const SizedBox(height: DsfrSpacings.s1w),
              FeedbackStars(
                size: 32,
                value: state.rate,
                onChanged: (final value) => context.read<ActionFeedbackBloc>().add(ActionFeedbackRateChanged(value)),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              DsfrInput(
                label: Localisation.commentPourrionsNousLAmeliorer,
                onChanged: (final value) {
                  context.read<ActionFeedbackBloc>().add(ActionFeedbackMessageChanged(value));
                },
                maxLines: 6,
                maxLength: 500,
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: DsfrButton(
                    label: Localisation.envoyer,
                    icon: DsfrIcons.systemArrowRightSLine,
                    iconLocation: DsfrButtonIconLocation.right,
                    variant: DsfrButtonVariant.secondary,
                    size: DsfrComponentSize.lg,
                    onPressed: () => context.read<ActionFeedbackBloc>().add(const ActionFeedbackSendRequested()),
                  ),
                ),
              ),
            ],
          ),
      listener: (final context, final state) {
        if (state.isSend) {
          GoRouter.of(context).pop(true);
        }
      },
    ),
  );
}

import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/core/presentation/widgets/composants/modal.dart';
import 'package:app/features/gamification/reset/presentation/widgets/reset_widget.dart';
import 'package:app/features/home/presentation/widgets/home_content_layout.dart';
import 'package:app/features/onboarding/pseudonym/presentation/pages/onboarding_pseudonym_page.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const UserFetchRequested());
  }

  Future<void> _handleNotifications(final BuildContext context) async {
    final notificationService = context.read<NotificationService>();
    final authorizationStatus = await notificationService.requestPermission();
    if (authorizationStatus == AuthorizationStatus.authorized && context.mounted) {
      await context.read<NotificationRepository>().saveToken();
    }
  }

  @override
  Widget build(final BuildContext context) => BlocConsumer<UserBloc, UserState>(
    builder: (final context, final state) {
      final user = state.user;
      if (user == null || !user.isIntegrationCompleted) {
        return const Center(child: CircularProgressIndicator());
      }

      return const HomeContentLayout();
    },
    listener: (final context, final state) async {
      final user = state.user;
      if (user == null) {
        return;
      }
      final estIntegrationTerminee = user.isIntegrationCompleted;

      if (!estIntegrationTerminee) {
        await GoRouter.of(context).pushReplacementNamed(OnboardingPseudonymPage.name);

        return;
      }

      await _handleNotifications(context);

      if (context.mounted && !user.shouldShowResetPopup) {
        await FnvModal.showFullModal<void>(
          context: context,
          builder: (final context) => const ResetModal(),
          name: 'reset-modal',
          isDismissible: false,
        );
      }
    },
    listenWhen: (final previous, final current) =>
        previous.user?.isIntegrationCompleted != current.user?.isIntegrationCompleted ||
        previous.user?.shouldShowResetPopup != current.user?.shouldShowResetPopup,
  );
}

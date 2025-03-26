import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/gamification/reset/presentation/widgets/reset_widget.dart';
import 'package:app/features/home/presentation/widgets/home_content_layout.dart';
import 'package:app/features/onboarding/pseudonym/presentation/pages/onboarding_pseudonym_page.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_state.dart';
import 'package:dsfr/dsfr.dart';
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
    _initializeData();
  }

  void _initializeData() {
    context.read<UserBloc>().add(const UserFetchRequested());
    context.read<EnvironmentalPerformanceBloc>().add(const EnvironmentalPerformanceStarted());
  }

  Future<void> _handleNotifications(final BuildContext context) async {
    final notificationService = context.read<NotificationService>();
    final authorizationStatus = await notificationService.requestPermission();
    if (authorizationStatus == AuthorizationStatus.authorized && context.mounted) {
      await context.read<NotificationRepository>().saveToken();
    }
  }

  @override
  Widget build(final context) => BlocListener<UserBloc, UserState>(
    listener: (final context, final state) async {
      final user = state.user;
      final estIntegrationTerminee = user.isIntegrationCompleted;
      if (estIntegrationTerminee == null) {
        return;
      }

      if (!estIntegrationTerminee) {
        await GoRouter.of(context).pushReplacementNamed(OnboardingPseudonymPage.name);

        return;
      }

      await _handleNotifications(context);

      if (context.mounted && user.shouldShowResetPopup != null && !user.shouldShowResetPopup!) {
        await DsfrModal.showFullModal<void>(
          context: context,
          builder: (final context) => const ResetModal(),
          name: 'reset-modal',
        );
      }
    },
    listenWhen:
        (final previous, final current) =>
            previous.user.isIntegrationCompleted != current.user.isIntegrationCompleted ||
            previous.user.shouldShowResetPopup != current.user.shouldShowResetPopup,
    child: const HomeContentLayout(),
  );
}

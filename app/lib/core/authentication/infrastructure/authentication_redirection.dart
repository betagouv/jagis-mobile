import 'package:app/app/router/deep_link.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_state.dart';
import 'package:app/core/authentication/presentation/restart_widget.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRedirection extends StatelessWidget {
  const AuthenticationRedirection({super.key, required this.deepLink, required this.child});

  final DeepLink deepLink;
  final Widget child;

  @override
  Widget build(final BuildContext context) => BlocListener<AuthenticationBloc, AuthenticationState>(
    listener: (final context, final state) {
      switch (state) {
        case AuthenticationInitial():
          break;
        case AuthenticationUnauthenticated():
          RestartWidget.restartApp(context);
        case AuthenticationAuthenticated():
          deepLink.hasDeepLink ? GoRouter.of(context).go(deepLink.consumeRoute()) : GoRouter.of(context).goNamed(HomePage.name);
      }
    },
    bloc: context.read(),
    child: child,
  );
}

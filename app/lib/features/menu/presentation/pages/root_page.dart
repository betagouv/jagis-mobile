import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/menu/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, this.title, this.appBarBottom, required this.body});

  final Widget? title;
  final PreferredSizeWidget? appBarBottom;
  final Widget body;

  /// Retourne true si la page est à la racine de l'application
  ///
  /// go_router utilise garde la route '/' dans la configuration de la route (peut-être une erreur de ma part)
  /// ```text
  /// '/' => true
  /// '/', '/aides' => true
  /// '/', '/', '/aides => false
  /// '/', '/actions', '/actions/1', /aides => false
  /// ```
  bool _isAtRootLevel(final BuildContext context) => GoRouter.of(context).routerDelegate.currentConfiguration.matches.length <= 2;

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(title: title, bottom: appBarBottom, isRoot: _isAtRootLevel(context)),
    body: body,
    drawer: const Menu(),
  );
}

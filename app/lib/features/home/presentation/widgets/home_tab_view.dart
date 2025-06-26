import 'package:app/features/home/presentation/widgets/home_content.dart';
import 'package:app/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

// FIXME(lsaudon): Trouver un moyen d'avoir TabBar avec go_router
class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(final BuildContext context) {
    const themeTypes = [ThemeType.alimentation, ThemeType.transport, ThemeType.logement, ThemeType.consommation];

    final tabs = [
      const Tab(icon: Icon(DsfrIcons.buildingsHome4Line)),
      ...themeTypes.map((final theme) => Tab(text: theme.displayName)),
    ];
    final pages = [const HomeContent(), ...themeTypes.map((final theme) => ThemePage(themeType: theme))];

    return DefaultTabController(
      length: 5,
      child: RootPage(
        appBarBottom: HomeTabBar(textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2), tabs: tabs),
        body: TabBarView(physics: const NeverScrollableScrollPhysics(), children: pages),
      ),
    );
  }
}

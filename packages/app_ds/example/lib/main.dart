import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:example/main.directories.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

void main() {
  runApp(const WidgetbookApp());
}

@App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(final BuildContext context) => Widgetbook.material(
    directories: directories,
    appBuilder: (final context, final child) =>
        DsfrThemeModeProvider.withBuilder(isLightMode: true, builder: (final context) => child),
    addons: [
      if (kIsWeb) ViewportAddon([IosViewports.iPhoneSE, IosViewports.iPhone13ProMax, Viewports.none]),
      TextScaleAddon(min: 1, divisions: 1),
      BuilderAddon(
        name: 'a11y',
        builder: (final context, final child) => AccessibilityTools(child: child),
      ),
      SemanticsAddon(),
    ],
    lightTheme: ThemeData.light().copyWith(scaffoldBackgroundColor: DsfrColors.grey1000),
    darkTheme: ThemeData.dark().copyWith(scaffoldBackgroundColor: DsfrColors.grey50),
    themeMode: ThemeMode.light,
  );
}

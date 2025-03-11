import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter/material.dart';

void navigateToTheme(final BuildContext context, final ThemeType themeType) {
  switch (themeType) {
    case ThemeType.alimentation:
      DefaultTabController.of(context).animateTo(1);
    case ThemeType.transport:
      DefaultTabController.of(context).animateTo(2);
    case ThemeType.logement:
      DefaultTabController.of(context).animateTo(3);
    case ThemeType.consommation:
      DefaultTabController.of(context).animateTo(4);
    case ThemeType.decouverte:
      throw UnimplementedError();
  }
}

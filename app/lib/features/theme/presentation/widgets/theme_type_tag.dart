import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ThemeTypeTag extends StatelessWidget {
  const ThemeTypeTag({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => Semantics(
    label: themeType.displayNameWithoutEmoji,
    child: DsfrTag(
      label: themeType.displayName,
      size: DsfrComponentSize.sm,
      backgroundColor: themeType.backgroundColor,
      textColor: themeType.foregroundColor,
    ),
  );
}

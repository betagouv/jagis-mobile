import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

abstract final class FnvModal {
  const FnvModal._();

  static Future<T?> showFullModal<T>({
    required final BuildContext context,
    required final WidgetBuilder builder,
    required final String name,
    final bool isDismissible = true,
  }) => showDialog(
    context: context,
    builder: (final context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: DsfrModal(isDismissible: isDismissible, closeLabel: 'Fermer', child: builder(context)),
      ),
    ),
    barrierDismissible: isDismissible,
    barrierColor: DsfrColors.grey50.withAlpha(163),
    routeSettings: RouteSettings(name: name),
  );

  static DialogRoute<T> getModal<T>(
    final BuildContext context, {
    required final WidgetBuilder builder,
    final bool isDismissible = true,
  }) {
    final themes = InheritedTheme.capture(from: context, to: Navigator.of(context, rootNavigator: true).context);

    return DialogRoute(
      context: context,
      builder: (final context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: DsfrModal(isDismissible: isDismissible, closeLabel: 'Fermer', child: builder(context)),
        ),
      ),
      themes: themes,
      barrierColor: DsfrColors.grey50.withAlpha(163),
      barrierDismissible: isDismissible,
    );
  }

  static Future<void> push<T>(final BuildContext context, {required final DialogRoute<T>? dialogRoute}) async {
    if (dialogRoute == null) {
      return;
    }
    await Navigator.of(context, rootNavigator: true).push(dialogRoute);
  }

  static void pop<T>(final BuildContext context, {required final DialogRoute<T>? dialogRoute}) {
    if (dialogRoute == null) {
      return;
    }
    Navigator.of(context, rootNavigator: true).removeRoute(dialogRoute);
  }
}

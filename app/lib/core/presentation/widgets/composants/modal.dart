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
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: DsfrModal(isDismissible: isDismissible, closeLabel: 'Fermer', child: builder(context)),
      ),
    ),
    barrierDismissible: isDismissible,
    barrierColor: DsfrColors.grey50.withAlpha(163),
    routeSettings: RouteSettings(name: name),
  );
}

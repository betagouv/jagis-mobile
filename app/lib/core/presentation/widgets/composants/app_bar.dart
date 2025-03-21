// ignore_for_file: prefer-moving-to-variable

import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/gamification/presentation/widgets/global_points.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const preferredHeight = 59.0;

class FnvAppBar extends StatelessWidget implements PreferredSizeWidget {
  FnvAppBar({super.key, this.leading, this.title, this.bottom, this.isRoot = false})
    : preferredSize = Size.fromHeight(preferredHeight + (bottom == null ? 0 : 48));

  final Widget? leading;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final bool isRoot;

  @override
  final Size preferredSize;

  @override
  Widget build(final context) {
    Widget widget = SizedBox(
      height: preferredHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: DsfrSpacings.s1w, right: DsfrSpacings.s3w),
        child: Row(
          children: [
            leading ??
                IconButton(
                  iconSize: 24,
                  padding: const EdgeInsets.all(DsfrSpacings.s1w),
                  onPressed: () {
                    if (isRoot) {
                      Scaffold.of(context).openDrawer();

                      return;
                    }
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    }
                  },
                  style: const ButtonStyle(shape: WidgetStatePropertyAll(roundedRectangleBorder)),
                  icon: Icon(
                    isRoot ? DsfrIcons.systemMenuFill : DsfrIcons.systemArrowLeftLine,
                    color: DsfrColors.blueFranceSun113,
                    semanticLabel: isRoot ? Localisation.menu : Localisation.retour,
                  ),
                ),
            if (title == null) const Spacer() else ...[const SizedBox(width: DsfrSpacings.s1w), Expanded(child: title!)],
            const SizedBox(width: DsfrSpacings.s1w),
            const GlobalPoints(),
          ],
        ),
      ),
    );

    if (bottom != null) {
      widget = Column(children: [widget, bottom!]);
    }

    return Material(
      color: FnvColors.appBarFond,
      child: DecoratedBox(decoration: const BoxDecoration(boxShadow: appBarOmbre), child: SafeArea(child: widget)),
    );
  }
}

import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends TabBar {
  const HomeTabBar({super.key, required TextScaler super.textScaler, required super.tabs})
    : super(
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: DsfrColors.blueFranceSun113, width: 3)),
        dividerHeight: 0,
        labelStyle: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113),
        labelPadding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
        unselectedLabelStyle: const DsfrTextStyle.bodyMd(),
        tabAlignment: TabAlignment.start,
      );
}

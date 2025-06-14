import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title, required this.subTitle, required this.onTap});

  final String title;
  final String subTitle;
  final GestureTapCallback onTap;

  @override
  Widget build(final BuildContext context) => Material(
    color: FnvColors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(paddingVerticalPage),
        child: Row(
          spacing: DsfrSpacings.s1v,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const DsfrTextStyle.headline6(color: DsfrColors.grey50)),
                  Text(
                    subTitle,
                    style: const DsfrTextStyle.bodyXs(color: Color(0xFF7E7E7E)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const Icon(DsfrIcons.systemArrowRightSLine),
          ],
        ),
      ),
    ),
  );
}

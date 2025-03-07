import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrNotice extends StatelessWidget {
  const DsfrNotice({super.key, required this.titre, required this.description, required this.onClose});

  final String titre;
  final String description;
  final VoidCallback? onClose;

  @override
  Widget build(final context) {
    const color = DsfrColors.info425;
    const textStyle = DsfrTextStyle.bodySm(color: color);

    return ColoredBox(
      color: DsfrColors.info950,
      child: Padding(
        padding: const EdgeInsets.only(left: DsfrSpacings.s2w, bottom: DsfrSpacings.s2w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1w,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: DsfrSpacings.s3v),
                child: Column(
                  children: [
                    Row(
                      spacing: DsfrSpacings.s1w,
                      children: [
                        const Icon(DsfrIcons.systemFrInfoFill, color: color),
                        Expanded(child: Text(titre, style: textStyle.copyWith(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Text(description, style: textStyle),
                  ],
                ),
              ),
            ),
            IconButton(
              iconSize: DsfrSpacings.s2w,
              onPressed: onClose,
              icon: const Icon(DsfrIcons.systemCloseLine, color: color, semanticLabel: 'Masquer le message'),
            ),
          ],
        ),
      ),
    );
  }
}

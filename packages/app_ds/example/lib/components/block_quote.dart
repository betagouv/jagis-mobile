import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Ressemble beaucoup à FnvCallout
@UseCase(
  type: FnvBlockQuote,
  name: 'Default',
  designLink: 'https://www.figma.com/design/CqHGLfk0uIdy61mDdZN0hv/J-agis-2025?node-id=17165-413000&t=fehBWDhYBNKlBsVt-4',
)
Widget buildBlockQuoteUseCase(final BuildContext context) {
  const color = Color(0xFF39826C);

  return FnvBlockQuote(
    color: color,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3v,
      children: [
        FnvEditTag(color: color, label: 'Vous mangez de la viande', onTap: () {}),
        FnvEditTag(color: color, label: 'Vous souhaitez faire des économies', onTap: () {}),
        FnvEditTag(
          color: color,
          label: "Mettre un texte assez long pour être sur deux lignes enfin j'espère que cela fonctionne",
          onTap: () {},
        ),
      ],
    ),
  );
}

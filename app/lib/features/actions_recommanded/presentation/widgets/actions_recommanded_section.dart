import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionsRecommandedSection extends StatelessWidget {
  const ActionsRecommandedSection({super.key});

  @override
  Widget build(final BuildContext context) => const ColoredBox(
    color: Color(0xFFF3EDE5),
    child: Padding(
      padding: EdgeInsets.only(left: DsfrSpacings.s2w, top: DsfrSpacings.s4w, right: DsfrSpacings.s2w, bottom: DsfrSpacings.s6w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mes actions recommandées', style: DsfrTextStyle.headline3()),
          SizedBox(height: DsfrSpacings.s1w),
          Text(
            'Afin d’obtenir vos actions personnalisées, pouvez-vous nous en dire un peu plus sur vous ?',
            style: DsfrTextStyle.bodyMd(),
          ),
          SizedBox(height: DsfrSpacings.s2w),
          Placeholder(),
        ],
      ),
    ),
  );
}

import 'package:app/core/infrastructure/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionInformation extends StatelessWidget {
  const ActionInformation({super.key, required this.icon, required this.value, required this.singular, required this.plural});

  final IconData icon;
  final int value;
  final String singular;
  final String plural;

  @override
  Widget build(final BuildContext context) => value == 0
      ? const SizedBox.shrink()
      : ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: DsfrSpacings.s1v,
            children: [
              ExcludeSemantics(child: Icon(icon, size: 14, color: DsfrColors.blueFranceSun113)),
              Expanded(
                child: FnvMarkdown(
                  data: '**$value** ${value == 1 ? singular : plural}',
                  p: const DsfrTextStyle.bodySmMedium(color: Color(0xff5d5d5d)),
                ),
              ),
            ],
          ),
        );
}

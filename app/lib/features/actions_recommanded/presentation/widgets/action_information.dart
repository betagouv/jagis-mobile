import 'package:app/core/infrastructure/markdown.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ActionInformation extends StatelessWidget {
  const ActionInformation({super.key, required this.icon, required this.value, required this.suffix});

  final IconData icon;
  final int value;
  final String suffix;

  @override
  Widget build(final context) =>
      value == 0
          ? const SizedBox()
          : ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: DsfrSpacings.s1w,
              children: [
                ExcludeSemantics(child: Icon(icon, size: 18, color: DsfrColors.blueFranceSun113)),
                Expanded(
                  child: FnvMarkdown(
                    data: '**$value** $suffix${value > 1 ? 's' : ''}',
                    p: const DsfrTextStyle.bodySmMedium(color: Color(0xff5d5d5d)),
                  ),
                ),
              ],
            ),
          );
}

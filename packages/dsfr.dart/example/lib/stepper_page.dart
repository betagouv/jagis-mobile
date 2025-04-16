import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatelessWidget {
  const StepperPage({super.key});

  static final model = PageItem(title: 'Étapier', pageBuilder: (final context) => const StepperPage());

  @override
  Widget build(final BuildContext context) {
    const length = 9;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1w,
        children: List.generate(length, (final index) => DsfrStepper(title: '$index étape', current: index, total: length - 1)),
      ),
    );
  }
}

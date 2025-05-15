import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class RecipeDifficulty extends StatelessWidget {
  const RecipeDifficulty({super.key, required this.value});

  final String value;

  @override
  Widget build(final BuildContext context) => DsfrTag(
    label: value,
    size: DsfrComponentSize.md,
    backgroundColor: const Color(0xffEAEAEA),
    textColor: const Color(0xff3F3F3F),
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class EstimadedTimedInfo extends StatelessWidget {
  const EstimadedTimedInfo({super.key, required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) {
    const color = Color(0xff6A6A6A);

    return Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(child: Icon(DsfrIcons.systemTimerLine, size: 16, color: color)),
          const WidgetSpan(child: SizedBox(width: DsfrSpacings.s0v5)),
          TextSpan(
            text: text,
            style: const DsfrTextStyle.bodySmMedium(color: color),
          ),
        ],
      ),
    );
  }
}

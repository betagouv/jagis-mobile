import 'package:flutter/cupertino.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvStepper extends StatelessWidget {
  const FnvStepper({super.key, required this.currentStep, required this.stepsCount, required this.stepTitle})
    : assert(currentStep > 0 && currentStep <= stepsCount);

  final String stepTitle;
  final int currentStep;
  final int stepsCount;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 12,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            'Question $currentStep sur $stepsCount',
            style: DsfrTextStyle.bodySm(color: DsfrColorDecisions.textDefaultGrey(context)),
          ),
          Text(stepTitle, style: DsfrTextStyle.bodyXlBold(color: DsfrColorDecisions.textTitleGrey(context))),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          for (var i = 1; i <= stepsCount; i += 1)
            Expanded(
              child: ColoredBox(
                color: i <= currentStep
                    ? DsfrColorDecisions.backgroundActiveBlueFrance(context)
                    : DsfrColorDecisions.backgroundContrastGrey(context),
                child: const SizedBox(height: 8),
              ),
            ),
        ],
      ),
    ],
  );
}

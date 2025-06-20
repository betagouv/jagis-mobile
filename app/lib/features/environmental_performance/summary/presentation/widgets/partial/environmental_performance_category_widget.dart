import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class EnvironmentalPerformanceCategoryWidget extends StatelessWidget {
  const EnvironmentalPerformanceCategoryWidget({
    super.key,
    required this.imageUrl,
    required this.completion,
    required this.label,
    required this.numberOfQuestions,
    required this.onTap,
  });

  final String imageUrl;
  final int completion;
  final String label;
  final int numberOfQuestions;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final progression = completion / 100;

    final color = progression >= 1 ? DsfrColors.success425 : DsfrColors.blueFranceSun113;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 11),
          child: _Card(
            onTap: onTap,
            imageUrl: imageUrl,
            progression: progression,
            color: color,
            completion: completion,
            label: label,
            numberOfQuestions: numberOfQuestions,
          ),
        ),
        if (progression >= 1) _Badge(label: 'TERMINÉ !', backgroundColor: color),
      ],
    );
  }
}

class _Card extends StatefulWidget {
  const _Card({
    required this.onTap,
    required this.imageUrl,
    required this.progression,
    required this.color,
    required this.completion,
    required this.label,
    required this.numberOfQuestions,
  });

  final VoidCallback onTap;
  final String imageUrl;
  final double progression;
  final Color color;
  final int completion;
  final String label;
  final int numberOfQuestions;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> with MaterialStateMixin<_Card> {
  static const _imageSize = 140.0;

  @override
  Widget build(final BuildContext context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: FnvShadows.card),
      child: Material(
        color: FnvColors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: FnvColors.transparent,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s1w,
              top: DsfrSpacings.s1w,
              right: DsfrSpacings.s1w,
              bottom: DsfrSpacings.s3v,
            ),
            child: SizedBox(
              width: _imageSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FnvImage.network(widget.imageUrl, width: _imageSize, height: _imageSize),
                  const SizedBox(height: DsfrSpacings.s1v),
                  LinearProgressIndicator(
                    value: widget.progression,
                    backgroundColor: const Color(0xFFEEEEFF),
                    color: widget.color,
                    minHeight: DsfrSpacings.s1v5,
                    semanticsLabel: 'Bilan complété à ${widget.completion}%',
                    borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
                  Text(widget.label, style: const DsfrTextStyle.bodyLgMedium(color: DsfrColors.grey50)),
                  Text('${widget.numberOfQuestions} questions', style: DsfrTextStyle.bodySm(color: widget.color)),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.backgroundColor});

  final String label;
  final Color backgroundColor;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(color: backgroundColor, shape: const StadiumBorder()),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s0v5, horizontal: DsfrSpacings.s1w),
      child: Text(label, style: const DsfrTextStyle.bodySmBold(color: Colors.white)),
    ),
  );
}

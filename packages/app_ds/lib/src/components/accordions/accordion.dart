import 'package:app_ds/src/components/accordions/accordion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

typedef FnvAccordionCallback = void Function(bool isExpanded);

// TODO(lsaudon): Rendre plus générique
class FnvAccordion extends StatefulWidget {
  const FnvAccordion({super.key, required this.item, required this.isExpanded, required this.onAccordionCallback});

  final FnvAccordionItem item;
  final bool isExpanded;
  final FnvAccordionCallback onAccordionCallback;

  @override
  State<FnvAccordion> createState() => _FnvAccordionState();
}

class _FnvAccordionState extends State<FnvAccordion> with MaterialStateMixin<FnvAccordion> {
  void _handleTap() => widget.onAccordionCallback(!widget.isExpanded);

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      InkWell(
        onTap: widget.item.isEnable ? _handleTap : null,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        focusColor: Colors.transparent,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: DsfrFocusWidget(
          isFocused: isFocused,
          child: ColoredBox(
            color: widget.isExpanded ? DsfrColors.blueFrance925 : Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.only(left: DsfrSpacings.s3v, top: DsfrSpacings.s3v, bottom: DsfrSpacings.s3v),
                child: Row(
                  children: [
                    Expanded(child: widget.item.headerBuilder!(widget.isExpanded)),
                    if (widget.item.isEnable)
                      AnimatedRotation(
                        turns: widget.isExpanded ? -0.5 : 0,
                        duration: Durations.short4,
                        child: const Icon(
                          DsfrIcons.systemArrowDownSLine,
                          size: DsfrSpacings.s2w,
                          color: DsfrColors.blueFranceSun113,
                        ),
                      ),
                    const SizedBox(width: DsfrSpacings.s2w),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: Padding(
          padding: const EdgeInsets.only(top: DsfrSpacings.s2w, bottom: DsfrSpacings.s3w),
          child: widget.item.body,
        ),
        crossFadeState: widget.isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Durations.short4,
      ),
    ],
  );
}

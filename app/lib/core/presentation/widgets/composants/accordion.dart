import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

typedef FnvAccordionCallback = void Function(int panelIndex, bool isExpanded);
typedef FnvAccordionHeaderBuilder = Widget Function(bool isExpanded);

class FnvAccordion {
  const FnvAccordion({this.headerBuilder, required this.body, this.isEnable = true});

  final FnvAccordionHeaderBuilder? headerBuilder;
  final Widget body;
  final bool isEnable;
}

class FnvAccordionsGroup extends StatefulWidget {
  const FnvAccordionsGroup({super.key, required this.values});

  final List<FnvAccordion> values;

  @override
  State<FnvAccordionsGroup> createState() => _FnvAccordionsGroupState();
}

class _FnvAccordionsGroupState extends State<FnvAccordionsGroup> {
  int? _panelIndex;
  var _isExpanded = false;

  void _handleCallback(final int? panelIndex, final bool isExpanded) => setState(() {
    _panelIndex = panelIndex;
    _isExpanded = isExpanded;
  });

  @override
  Widget build(final BuildContext context) {
    const divider = DsfrDivider();

    return Column(
      children: [
        divider,
        ...widget.values.indexed
            .map((final (int, FnvAccordion) e) {
              final (index, item) = e;

              return _FnvAccordion(
                index: index,
                item: item,
                isExpanded: _panelIndex == index && _isExpanded,
                onAccordionCallback: _handleCallback,
              );
            })
            .separator(divider),
        divider,
      ],
    );
  }
}

class _FnvAccordion extends StatefulWidget {
  const _FnvAccordion({required this.index, required this.item, required this.isExpanded, required this.onAccordionCallback});

  final int index;
  final FnvAccordion item;
  final bool isExpanded;
  final FnvAccordionCallback onAccordionCallback;

  @override
  State<_FnvAccordion> createState() => _FnvAccordionState();
}

class _FnvAccordionState extends State<_FnvAccordion> with MaterialStateMixin<_FnvAccordion> {
  void _handleTap() => widget.onAccordionCallback(widget.index, !widget.isExpanded);

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

import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FnvLink extends StatefulWidget {
  const FnvLink({
    super.key,
    required this.label,
    this.iconPosition = DsfrLinkIconPosition.start,
    this.icon,
    this.onTap,
    this.size = DsfrComponentSize.md,
    this.enabled = true,
    this.textAlign = TextAlign.start,
  });

  final String label;
  final IconData? icon;
  final DsfrLinkIconPosition iconPosition;
  final VoidCallback? onTap;
  final DsfrComponentSize size;
  final bool enabled;
  final TextAlign textAlign;

  @override
  State<FnvLink> createState() => _FnvLinkState();
}

class _FnvLinkState extends State<FnvLink> with MaterialStateMixin<FnvLink> {
  @override
  void initState() {
    super.initState();
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  DsfrTextStyle _getTextStyle(final BuildContext context) {
    final textColor = _getColor(context);

    return switch (widget.size) {
      DsfrComponentSize.lg => DsfrTextStyle.bodyLg(color: textColor),
      DsfrComponentSize.md => DsfrTextStyle.bodyMd(color: textColor),
      DsfrComponentSize.sm => DsfrTextStyle.bodySm(color: textColor),
    };
  }

  Color _getColor(final BuildContext context) => widget.onTap == null || !widget.enabled
      ? DsfrColorDecisions.textDisabledGrey(context)
      : DsfrColorDecisions.textActionHighBlueFrance(context);

  double _getIconSize() => switch (widget.size) {
    DsfrComponentSize.lg => 24,
    DsfrComponentSize.md || DsfrComponentSize.sm => 16,
  };

  double _getClickedUnderlineThickness() => switch (widget.size) {
    DsfrComponentSize.lg => 2.25,
    DsfrComponentSize.md => 2,
    DsfrComponentSize.sm => 1.75,
  };

  @override
  void didUpdateWidget(final FnvLink oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  Widget build(final context) {
    final list = [
      if (widget.icon != null)
        WidgetSpan(
          alignment: PlaceholderAlignment.top,
          child: Padding(
            padding: widget.iconPosition == DsfrLinkIconPosition.start
                ? const EdgeInsets.only(right: DsfrSpacings.s1w)
                : const EdgeInsets.only(left: DsfrSpacings.s1w),
            child: Icon(widget.icon, size: _getIconSize(), color: _getColor(context)),
          ),
        ),
      TextSpan(text: widget.label),
    ];

    final backgroundTransparent = DsfrColorDecisions.backgroundTransparent(context);

    return Semantics(
      enabled: widget.onTap != null,
      link: true,
      child: Material(
        color: backgroundTransparent,
        child: InkWell(
          onTap: widget.enabled ? widget.onTap : null,
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: DsfrColorDecisions.backgroundTransparentHover(context),
          highlightColor: DsfrColorDecisions.backgroundTransparentActive(context),
          canRequestFocus: widget.onTap != null,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: DsfrFocusWidget(
            isFocused: isFocused,
            child: Text.rich(
              TextSpan(children: widget.iconPosition == DsfrLinkIconPosition.start ? list : list.reversed.toList()),
              style: _getTextStyle(context).copyWith(
                color: backgroundTransparent,
                shadows: [Shadow(color: _getColor(context), offset: const Offset(0, -5))],
                decoration: isDisabled ? TextDecoration.none : TextDecoration.underline,
                decorationColor: _getColor(context),
                decorationThickness: isPressed || isHovered ? _getClickedUnderlineThickness() : 1,
              ),
              textAlign: widget.textAlign,
            ),
          ),
        ),
      ),
    );
  }
}

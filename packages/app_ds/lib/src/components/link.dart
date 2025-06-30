import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

/// Utilisé DsfrLink par défaut.
///
/// À utiliser uniquement si il y un emoji dans le lien
///
/// Il a été fait pour réglé le souci qui semble avoir avec
/// la font DSFR et Flutter qui souligne bizarrement
/// quand il y a un emoji.
/// Ce widget gère mal le fait de souligné sur le multiligne
class FnvLink extends StatefulWidget {
  const FnvLink({
    super.key,
    required this.label,
    this.onTap,
    this.size = DsfrComponentSize.md,
    this.enabled = true,
    this.textAlign = TextAlign.start,
  });

  final String label;
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
  Widget build(final context) => DsfrFocusWidget(
    isFocused: isFocused,
    child: Semantics(
      enabled: widget.onTap != null,
      link: true,
      child: Material(
        color: DsfrColorDecisions.backgroundTransparent(context),
        child: InkWell(
          onTap: widget.enabled ? widget.onTap : null,
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: DsfrColorDecisions.backgroundTransparentHover(context),
          highlightColor: DsfrColorDecisions.backgroundTransparentActive(context),
          canRequestFocus: widget.onTap != null,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: !isFocused && !isDisabled
                  ? Border(
                      bottom: BorderSide(
                        color: _getColor(context),
                        width: isPressed || isHovered ? _getClickedUnderlineThickness() : 1,
                      ),
                    )
                  : null,
            ),
            child: Text(widget.label, style: _getTextStyle(context), textAlign: widget.textAlign),
          ),
        ),
      ),
    ),
  );
}

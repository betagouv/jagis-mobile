import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class AppTag extends StatefulWidget {
  const AppTag({
    super.key,
    required this.label,
    required this.size,
    this.backgroundColor,
    this.highlightColor,
    this.textColor,
    this.selectedBackgroundColor,
    this.selectedHighlightColor,
    this.selectedTextColor,
    this.icon,
    this.onTap,
    this.focusNode,
    this.isSelected = false,
    this.onSelectionChanged,
    this.enabled = true,
    this.onDelete,
  }) : assert(
         (onSelectionChanged == null || onTap == null) &&
             (onSelectionChanged == null || onDelete == null) &&
             (onTap == null || onDelete == null),
       );

  final InlineSpan label;
  final DsfrComponentSize size;
  final GestureTapCallback? onTap;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? highlightColor;
  final Color? textColor;
  final Color? selectedBackgroundColor;
  final Color? selectedHighlightColor;
  final Color? selectedTextColor;
  final FocusNode? focusNode;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;
  final bool enabled;
  final GestureTapCallback? onDelete;

  @override
  State<AppTag> createState() => _AppTagState();
}

class _AppTagState extends State<AppTag> {
  var _hasFocus = false;
  bool get _hasNoCustomBackgroundColors => widget.backgroundColor == null && widget.highlightColor == null;

  bool get _hasNoCustomSelectedBackgroundColors =>
      widget.selectedBackgroundColor == null && widget.selectedHighlightColor == null;

  bool get _shouldUseDefaultHighlightColor =>
      (!widget.isSelected && _hasNoCustomBackgroundColors) ||
      (widget.isSelected && _hasNoCustomBackgroundColors && _hasNoCustomSelectedBackgroundColors);

  bool get _isClickable => widget.onTap != null || widget.onDelete != null || widget.onSelectionChanged != null;

  Color _getTextColor(final BuildContext context) {
    if (widget.enabled) {
      return widget.isSelected
          ? (widget.selectedTextColor ?? DsfrColorDecisions.textInvertedBlueFrance(context))
          : (widget.textColor ?? DsfrColorDecisions.textActionHighBlueFrance(context));
    }

    return DsfrColorDecisions.textDisabledGrey(context);
  }

  DsfrTextStyle _getTextStyle(final BuildContext context) {
    final textColor = _getTextColor(context);

    return switch (widget.size) {
      DsfrComponentSize.md => DsfrTextStyle.bodyMd(color: textColor),
      DsfrComponentSize.sm => DsfrTextStyle.bodySm(color: textColor),
      DsfrComponentSize.lg => throw UnimplementedError('Size ${widget.size} is not implemented'),
    };
  }

  double _getIconFontSize() => switch (widget.size) {
    DsfrComponentSize.md => 16,
    DsfrComponentSize.sm => 12,
    DsfrComponentSize.lg => throw UnimplementedError('Size ${widget.size} is not implemented'),
  };

  EdgeInsets _getPadding() => switch (widget.size) {
    DsfrComponentSize.md => const EdgeInsets.fromLTRB(12, 4, 20, 4),
    DsfrComponentSize.sm => const EdgeInsets.fromLTRB(8, 2, 14, 2),
    DsfrComponentSize.lg => throw UnimplementedError('Size ${widget.size} is not implemented'),
  };

  Color _getBackgroundColor(final BuildContext context) {
    if (widget.enabled) {
      return widget.isSelected
          ? (widget.selectedBackgroundColor ?? DsfrColorDecisions.backgroundActionHighBlueFrance(context))
          : (widget.backgroundColor ?? DsfrColorDecisions.backgroundActionLowBlueFrance(context));
    }

    return DsfrColorDecisions.backgroundDisabledGrey(context);
  }

  Color? _getHighlightColor(final BuildContext context) {
    if (widget.enabled) {
      if (!_isClickable) {
        return _getBackgroundColor(context);
      }

      return _shouldUseDefaultHighlightColor
          ? widget.isSelected
                ? DsfrColorDecisions.backgroundActionHighBlueFranceHover(context)
                : DsfrColorDecisions.backgroundActionLowBlueFranceHover(context)
          : widget.isSelected
          ? widget.selectedHighlightColor
          : widget.highlightColor;
    }

    return DsfrColorDecisions.backgroundDisabledGrey(context);
  }

  @override
  Widget build(final context) {
    final enabled = widget.enabled;
    final isSelected = widget.isSelected;
    final size = widget.size;
    final label = widget.label;
    final onTap = widget.onTap;
    final icon = widget.icon;
    final onSelectionChanged = widget.onSelectionChanged;
    final focusNode = widget.focusNode;

    return MergeSemantics(
      child: Semantics(
        enabled: enabled,
        selected: onSelectionChanged != null && isSelected,
        button: onTap != null,
        child: DsfrFocusWidget(
          isFocused: _hasFocus,
          child: CustomPaint(
            painter: _CustomShapePainter(size, _getBackgroundColor(context), isSelected),
            child: ClipPath(
              clipper: _CustomShapeClipper(size, isSelected),
              child: _TagButton(
                label: label,
                padding: _getPadding(),
                backgroundColor: _getBackgroundColor(context),
                highlightColor: _getHighlightColor(context),
                textStyle: _getTextStyle(context),
                icon: widget.onDelete == null ? icon : null,
                iconFontSize: _getIconFontSize(),
                onTap: onTap,
                isSelected: isSelected,
                onSelectionChanged: onSelectionChanged,
                enabled: enabled,
                onDelete: widget.onDelete,
                isClickable: _isClickable,
                focusNode: focusNode,
                onFocusChange: (final hasFocus) => setState(() => _hasFocus = hasFocus),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TagButton extends StatelessWidget {
  const _TagButton({
    required this.label,
    required this.padding,
    this.backgroundColor,
    this.highlightColor,
    required this.textStyle,
    this.icon,
    this.iconFontSize,
    this.onTap,
    this.isSelected = false,
    this.onSelectionChanged,
    this.enabled = true,
    this.onDelete,
    this.isClickable = true,
    this.focusNode,
    this.onFocusChange,
  });

  final InlineSpan label;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;
  final IconData? icon;
  final double? iconFontSize;
  final Color? backgroundColor;
  final Color? highlightColor;
  final DsfrTextStyle textStyle;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;
  final bool enabled;
  final GestureTapCallback? onDelete;
  final bool isClickable;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  @override
  Widget build(final BuildContext context) => Material(
    color: backgroundColor,
    shape: isSelected ? null : const StadiumBorder(),
    child: InkWell(
      onTap: enabled && isClickable
          ? () {
              if (onSelectionChanged != null) {
                onSelectionChanged!(!isSelected);
              } else if (onDelete != null) {
                onDelete!();
              } else {
                onTap?.call();
              }
            }
          : null,
      highlightColor: highlightColor,
      splashFactory: enabled && isClickable ? null : NoSplash.splashFactory,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      child: Padding(
        padding: padding,
        child: Text.rich(
          TextSpan(
            children: [
              if (icon != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  baseline: TextBaseline.alphabetic,
                  child: Padding(
                    padding: const EdgeInsets.only(right: DsfrSpacings.s1v),
                    child: Icon(icon, size: iconFontSize, color: textStyle.color),
                  ),
                ),
              label,
              if (onDelete != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  baseline: TextBaseline.alphabetic,
                  child: Padding(
                    padding: const EdgeInsets.only(left: DsfrSpacings.s1v),
                    child: Icon(DsfrIcons.systemCloseLine, size: iconFontSize, color: textStyle.color),
                  ),
                ),
            ],
          ),
          style: textStyle,
        ),
      ),
    ),
  );
}

const _tagCornerRadius = 40.0;
const _tagRadiusSizeS = 4.5;
const _tagRadiusSizeM = 6.0;
const _tagStrokeWidthSizeS = 1.2;
const _tagStrokeWidthSizeM = 1.5;
const _spaceBetweenButtonAndTag = 1.0;

class _CustomShapeClipper extends CustomClipper<Path> {
  const _CustomShapeClipper(this.componentSize, this.selected);

  final DsfrComponentSize componentSize;
  final bool selected;

  @override
  Path getClip(final Size size) {
    final path = Path();
    final tagRadius = (componentSize == DsfrComponentSize.md) ? _tagRadiusSizeM : _tagRadiusSizeS;
    final tagStrokeWidth = (componentSize == DsfrComponentSize.md) ? _tagStrokeWidthSizeM : _tagStrokeWidthSizeS;

    final cutoutRadius = tagRadius + tagStrokeWidth + _spaceBetweenButtonAndTag;
    final cutoutCenter = Offset(size.width - cutoutRadius, cutoutRadius / 2);

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width - cutoutRadius, size.height),
        const Radius.circular(_tagCornerRadius),
      ),
    );
    if (!selected) {
      return path;
    }
    final cutoutPath = Path()..addOval(Rect.fromCircle(center: cutoutCenter, radius: cutoutRadius));

    return Path.combine(PathOperation.difference, path, cutoutPath);
  }

  @override
  bool shouldReclip(covariant final CustomClipper<Path> oldClipper) {
    if (oldClipper is _CustomShapeClipper) {
      return oldClipper.componentSize != componentSize || oldClipper.selected != selected;
    }

    return true;
  }
}

class _CustomShapePainter extends CustomPainter {
  const _CustomShapePainter(this.componentSize, this.backgroundColor, this.selected);

  final DsfrComponentSize componentSize;
  final Color backgroundColor;
  final bool selected;

  @override
  void paint(final Canvas canvas, final Size size) {
    final path = Path();
    final tagRadius = (componentSize == DsfrComponentSize.md) ? _tagRadiusSizeM : _tagRadiusSizeS;
    final tagStrokeWidth = (componentSize == DsfrComponentSize.md) ? _tagStrokeWidthSizeM : _tagStrokeWidthSizeS;
    final tagPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final tagCheckIconPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = tagStrokeWidth
      ..style = PaintingStyle.stroke;

    final cutoutRadius = tagRadius + tagStrokeWidth + _spaceBetweenButtonAndTag;
    final cutoutCenter = Offset(size.width - cutoutRadius, cutoutRadius / 3);

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width - cutoutRadius, size.height),
        const Radius.circular(_tagCornerRadius),
      ),
    );

    if (!selected) {
      canvas.drawPath(path, tagPaint);

      return;
    }

    final cutoutPath = Path()..addOval(Rect.fromCircle(center: cutoutCenter, radius: cutoutRadius));
    final finalPath = Path.combine(PathOperation.difference, path, cutoutPath);

    canvas
      ..drawPath(finalPath, tagPaint)
      ..drawCircle(cutoutCenter, tagRadius, tagCheckIconPaint);

    final tickPath = Path();
    final center = cutoutCenter;
    final radius = tagRadius;

    // Calculate tick points based on the circle's size
    // Starting point (left point of the tick)
    final startPoint = Offset(center.dx - radius * 0.65, center.dy);

    // Middle point (bottom point of the tick)
    final middlePoint = Offset(center.dx - radius * 0.1, center.dy + radius * 0.4);

    // End point (right point of the tick, higher up)
    final endPoint = Offset(center.dx + radius * 0.6, center.dy - radius * 0.35);

    // Create the tick path
    tickPath
      ..moveTo(startPoint.dx, startPoint.dy)
      ..lineTo(middlePoint.dx, middlePoint.dy)
      ..lineTo(endPoint.dx, endPoint.dy);

    // Draw the tick
    canvas.drawPath(tickPath, tagCheckIconPaint);
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    if (oldDelegate is _CustomShapePainter) {
      return oldDelegate.componentSize != componentSize || oldDelegate.selected != selected;
    }

    return true;
  }
}

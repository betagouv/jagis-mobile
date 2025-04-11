// ignore_for_file: prefer-correct-callback-field-name
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DsfrInputHeadless extends StatefulWidget {
  const DsfrInputHeadless({
    super.key,
    this.initialValue,
    this.focusNode,
    this.controller,
    this.suffixText,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.width,
    this.isPasswordMode = false,
    this.passwordVisibility = false,
    this.autocorrect,
    this.fillColor = DsfrColors.grey950,
    this.radius = DsfrSpacings.s1v,
    this.enabled,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.inputStyle = const DsfrTextStyle.bodyMd(),
    this.inputBorderColor = DsfrColors.grey200,
    this.inputBorderWidth = DsfrSpacings.s0v5,
    this.inputConstraints = const BoxConstraints(maxHeight: DsfrSpacings.s6w),
    this.focusColor = DsfrColors.focus525,
    this.focusThickness = DsfrSpacings.s0v5,
    this.focusPadding = const EdgeInsets.all(DsfrSpacings.s0v5),
    this.inputFormatters,
    this.scrollPadding = const EdgeInsets.all(20),
    this.autofillHints,
  });

  final String? initialValue;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? suffixText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final double? width;
  final TextStyle inputStyle;
  final TextAlign textAlign;
  final bool autofocus;
  final bool isPasswordMode;
  final bool passwordVisibility;
  final bool? autocorrect;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Color inputBorderColor;
  final double inputBorderWidth;
  final BoxConstraints? inputConstraints;
  final Color fillColor;
  final double radius;
  final Color focusColor;
  final double focusThickness;
  final EdgeInsetsGeometry focusPadding;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets scrollPadding;
  final Iterable<String>? autofillHints;

  @override
  State<DsfrInputHeadless> createState() => _DsfrInputHeadlessState();
}

class _DsfrInputHeadlessState extends State<DsfrInputHeadless> {
  var _isFocused = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_listener);
  }

  void _listener() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_listener);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final context) {
    final underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.inputBorderColor,
        width: widget.inputBorderWidth,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(widget.radius)),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: _isFocused ? widget.focusColor : Colors.transparent,
            width: widget.focusThickness,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(widget.radius + 2)),
      ),
      child: Padding(
        padding: widget.focusPadding.add(EdgeInsets.only(bottom: widget.inputBorderWidth)),
        child: SizedBox(
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            focusNode: _focusNode,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixText: widget.suffixText,
              suffixStyle: widget.inputStyle,
              counterStyle: const DsfrTextStyle.bodyXs(color: DsfrColors.grey200),
              filled: true,
              fillColor: widget.fillColor,
              focusedBorder: underlineInputBorder,
              enabledBorder: underlineInputBorder,
              border: underlineInputBorder,
              constraints: widget.maxLines == 1 ? widget.inputConstraints : null,
            ),
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            style: widget.inputStyle,
            textAlign: widget.textAlign,
            autofocus: widget.autofocus,
            obscureText: widget.isPasswordMode && !widget.passwordVisibility,
            autocorrect: widget.autocorrect ?? !widget.isPasswordMode,
            enableSuggestions: !widget.isPasswordMode,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onTapOutside: (final event) => FocusManager.instance.primaryFocus?.unfocus(),
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            scrollPadding: widget.scrollPadding,
            autofillHints: widget.autofillHints,
          ),
        ),
      ),
    );
  }
}

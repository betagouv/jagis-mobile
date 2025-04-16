// ignore_for_file: prefer-correct-callback-field-name

import 'package:dsfr/src/composants/checkbox.dart';
import 'package:dsfr/src/composants/input_headless.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DsfrInput extends StatefulWidget {
  const DsfrInput({
    super.key,
    required this.label,
    this.hintText,
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
    this.autocorrect,
    this.labelStyle = const DsfrTextStyle.bodyMd(),
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = const DsfrTextStyle.bodyXs(),
    this.hintColor = DsfrColors.grey425,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.enabled,
    this.maxLines = 1,
    this.maxLength,
    this.inputConstraints = const BoxConstraints(maxHeight: DsfrSpacings.s6w),
    this.inputFormatters,
    this.scrollPadding = const EdgeInsets.all(20),
    this.autofillHints,
  });

  final String label;
  final String? hintText;
  final String? suffixText;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final double? width;
  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;
  final TextAlign textAlign;
  final bool autofocus;
  final bool isPasswordMode;
  final bool? autocorrect;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final BoxConstraints? inputConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets scrollPadding;
  final Iterable<String>? autofillHints;

  @override
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  var _passwordVisibility = false;

  void _handlePasswordVisibility(final bool value) => setState(() => _passwordVisibility = value);

  @override
  Widget build(final BuildContext context) {
    final labelText = widget.label;
    Widget label = ExcludeSemantics(child: Text(labelText, style: widget.labelStyle.copyWith(color: widget.labelColor)));

    if (widget.isPasswordMode) {
      label = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: label),
          if (widget.isPasswordMode)
            FocusTraversalOrder(
              order: const NumericFocusOrder(2),
              child: DsfrCheckbox.sm(label: 'Afficher', value: _passwordVisibility, onChanged: _handlePasswordVisibility),
            ),
        ],
      );
    }

    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Semantics(
        textField: true,
        label: labelText,
        hint: widget.hintText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            if (widget.hintText != null) ...[
              const SizedBox(height: DsfrSpacings.s1v),
              ExcludeSemantics(child: Text(widget.hintText!, style: widget.hintStyle.copyWith(color: widget.hintColor))),
            ],
            const SizedBox(height: DsfrSpacings.s1w),
            FocusTraversalOrder(
              order: const NumericFocusOrder(1),
              child: Semantics(
                identifier: labelText,
                child: DsfrInputHeadless(
                  key: ValueKey(labelText),
                  initialValue: widget.initialValue,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  suffixText: widget.suffixText,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  textCapitalization: widget.textCapitalization,
                  textInputAction: widget.textInputAction,
                  width: widget.width,
                  isPasswordMode: widget.isPasswordMode,
                  passwordVisibility: _passwordVisibility,
                  autocorrect: widget.autocorrect,
                  enabled: widget.enabled,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  textAlign: widget.textAlign,
                  autofocus: widget.autofocus,
                  inputConstraints: widget.inputConstraints,
                  inputFormatters: widget.inputFormatters,
                  scrollPadding: widget.scrollPadding,
                  autofillHints: widget.autofillHints,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

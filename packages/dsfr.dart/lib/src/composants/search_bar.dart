// ignore_for_file: prefer-correct-callback-field-name
import 'dart:async';

import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrSearchBar extends StatefulWidget {
  const DsfrSearchBar({super.key, this.initialValue, required this.onChanged});

  final String? initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<DsfrSearchBar> createState() => _DsfrSearchBarState();
}

class _DsfrSearchBarState extends State<DsfrSearchBar> {
  Timer? _timer;
  var _isFocused = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_listener);
  }

  void _listener() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const inputBorderWidth = DsfrSpacings.s0v5;
    const radius = DsfrSpacings.s1v;
    const primaryColor = DsfrColors.blueFranceSun113;
    const underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: inputBorderWidth, strokeAlign: BorderSide.strokeAlignOutside),
      // ignore: avoid_redundant_argument_values
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
    );
    const inputStyle = DsfrTextStyle.bodyMd();
    const hintText = 'Rechercher par titre';

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: _isFocused ? DsfrColors.focus525 : Colors.transparent,
            width: inputBorderWidth,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(radius + 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(inputBorderWidth).add(const EdgeInsets.only(bottom: inputBorderWidth)),
        child: TextFormField(
          key: const ValueKey(hintText),
          initialValue: widget.initialValue,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: hintText,
            hintStyle: DsfrTextStyle.bodyMdItalic(),
            filled: true,
            fillColor: DsfrColors.grey950,
            focusedBorder: underlineInputBorder,
            enabledBorder: underlineInputBorder,
            border: underlineInputBorder,
            constraints: BoxConstraints(maxHeight: DsfrSpacings.s6w),
          ),
          textInputAction: TextInputAction.search,
          style: inputStyle,
          onChanged: (final value) {
            if (_timer?.isActive ?? false) {
              _timer?.cancel();
            }
            _timer = Timer(const Duration(milliseconds: 500), () => widget.onChanged(value));
          },
          onTapOutside: (final event) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
    );
  }
}

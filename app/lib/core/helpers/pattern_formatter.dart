import 'package:flutter/services.dart';

class PatternFormatter extends TextInputFormatter {
  const PatternFormatter({required final String pattern}) : _pattern = pattern;

  final String _pattern;

  @override
  TextEditingValue formatEditUpdate(final TextEditingValue oldValue, final TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > _pattern.replaceAll(' ', '').length) {
      return oldValue;
    }

    final formatted = _applyPattern(digits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _applyPattern(final String digits) {
    final buffer = StringBuffer();
    var digitIndex = 0;

    for (var i = 0; i < _pattern.length && digitIndex < digits.length; i += 1) {
      if (_pattern[i] == '#') {
        buffer.write(digits[digitIndex]);
        digitIndex += 1;
      } else {
        buffer.write(_pattern[i]);
      }
    }

    return buffer.toString();
  }
}

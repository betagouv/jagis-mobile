import 'package:flutter/widgets.dart';

String capitalize(final String text) => text[0].toUpperCase() + text.characters.getRange(1).string;

String titleToKebabCase(final String text) => {
      '-': ' ',
      'a': 'àáâäæãåā',
      'c': 'çćč',
      'e': 'èéêëēėę',
      'i': 'îïíīįì',
      'l': 'ł',
      'n': 'ñń',
      'o': 'ôöòóœøōõ',
      'u': 'ûüùúū',
      'y': 'ÿ',
      'z': 'żźž',
      'ss': 'ß',
      'g': 'ğ',
      's': 'ş',
    }.entries
    .fold(text, (final currentText, final entry) => currentText.replaceAll(RegExp('[${RegExp.escape(entry.value)}]'), entry.key))
    .toLowerCase()
    .trim()
    .replaceAll(RegExp("[’']"), '-')
    .replaceAll(RegExp('[^a-z0-9 -]'), '')
    .replaceAll(RegExp(r'\s+'), '-')
    .replaceAll(RegExp('-+'), '-');

import 'package:app/core/helpers/regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('removeEmoji', () {
    expect(removeEmoji('Hello world 🌍.'), equals('Hello world .'));
    expect(removeEmoji('👋 Hello 🌍 World! 🎉'), equals(' Hello  World! '));
    expect(removeEmoji('No emojis here'), equals('No emojis here'));
  });
}

// ignore_for_file: unused-code, unused-files, avoid-unused-parameters
import 'dart:async';

import '../step/initialize_context.dart';

abstract final class Hooks {
  const Hooks._();

  static Future<void> beforeEach(final String title, [final List<String>? tags]) async {
    await initializeContext();
  }

  static Future<void> beforeAll() async {}

  static Future<void> afterEach(final String title, final bool success, [final List<String>? tags]) async {}

  static Future<void> afterAll() async {}
}

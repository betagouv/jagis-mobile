import 'dart:core';

import 'package:fpdart/fpdart.dart';

abstract final class MesAidesRenoSituationMapper {
  static Map<String, String> toJson(final Map<String, dynamic> situation) => situation.mapValue(
    (final value) => switch (value.runtimeType.toString()) {
      'String' => throw UnimplementedError(),
      _ => throw UnimplementedError(),
    },
  );
}

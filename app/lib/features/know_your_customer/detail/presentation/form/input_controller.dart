import 'package:flutter/material.dart';

/// Controller used to notify the calling widget that the input has been edited.
class InputController extends ChangeNotifier {
  var _value = '';

  bool get isEmpty => _value.isEmpty;

  void updateValue(final String newValue) {
    _value = newValue;
    notifyListeners();
  }
}

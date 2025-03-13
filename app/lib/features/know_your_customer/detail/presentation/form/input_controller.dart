import 'package:flutter/material.dart';

/// Controller used to notify the calling widget that the input has been edited.
class InputController extends ChangeNotifier {
  void edited() {
    notifyListeners();
  }
}

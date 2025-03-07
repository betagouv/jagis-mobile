import 'package:flutter/material.dart';

class QuestionController extends ChangeNotifier {
  void save() {
    notifyListeners();
  }
}

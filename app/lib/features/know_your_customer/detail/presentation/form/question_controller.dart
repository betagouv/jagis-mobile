import 'package:flutter/material.dart';

enum QuestionControllerStatus { save, skip }

class QuestionController extends ChangeNotifier {
  QuestionControllerStatus _status = QuestionControllerStatus.save;
  QuestionControllerStatus get status => _status;
  void save() {
    _status = QuestionControllerStatus.save;
    notifyListeners();
  }

  void skip() {
    _status = QuestionControllerStatus.skip;
    notifyListeners();
  }
}

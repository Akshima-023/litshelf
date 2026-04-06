import 'package:flutter/material.dart';

class FeedbackProvider extends ChangeNotifier {
  int _rating = 0;
  String _feedback = "";

  int get rating => _rating;
  String get feedback => _feedback;

  void setRating(int value) {
    _rating = value;
    notifyListeners();
  }

  void setFeedback(String value) {
    _feedback = value;
  }

  void clear() {
    _rating = 0;
    _feedback = "";
    notifyListeners();
  }
}
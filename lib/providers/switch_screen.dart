import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SwitchScreen with ChangeNotifier {
  String _state = "All";
  String get state => _state;
  void toAll() {
    _state = "All";
    notifyListeners();
  }

  void toMe() {
    _state = "For Me";
    notifyListeners();
  } 
}

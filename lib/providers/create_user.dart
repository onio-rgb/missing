import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class login with ChangeNotifier {
  int _c = 0;
  int get c => _c;
  void gotologin() {
    _c = 0;
    notifyListeners();
  }

  void gotosignup() {
    _c = 1;
    notifyListeners();
  }
}

class CurrentUser with ChangeNotifier {
  
  String uid;
  CurrentUser({required this.uid});
  
}

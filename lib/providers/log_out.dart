import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:missing/globals.dart';
import 'package:provider/provider.dart';

class LogOut with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  Future<void> logout() async {
    auth.signOut();
    currentUid = "";
  }
}

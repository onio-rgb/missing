import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:missing/globals.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreateUser with ChangeNotifier {
  String _error = "";
  String get error => _error;
  final db = FirebaseFirestore.instance;

  Future<void> createUser(
      String email, String pass, String name, String mobile) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Map<String, dynamic> m = {
        'email': email,
        'pass': pass,
        'name': name,
        'phone': mobile
      };
      await db.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(m);
      currentUid = FirebaseAuth.instance.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _error = 'The password provided is too weak.';
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        _error = 'The account already exists for that email.';
        notifyListeners();
        
      }
    } catch (e) {
      print(e);
    }
  }
}

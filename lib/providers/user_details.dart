import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserDetails with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  Future<Map<String, dynamic>> getUser(String doc_ref) async {
    final snapshot = await db.collection('users').doc(doc_ref).get();
    return snapshot.data()!;
  }
}

import 'package:missing/globals.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MissingPeople with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _missing = [];
  List<Map<String, dynamic>> get missing => _missing;

  Future<void> getPerUser() async {
    missing.clear();
    final missing_peope = await db
        .collection('users')
        .doc(currentUid)
        .collection('missing people')
        .get();

    final x = missing_peope.docs;

    for (var a in x) {
      //print('${a.data()} AStitva');
      _missing.add(a.data());
    }
    notifyListeners();
  }

  Future<void> getAll() async {
    missing.clear();
    final users_ref = await db.collection('users').get();
    final users = users_ref.docs;
    for (var user in users) {
      final user_id = user.id;
      //print("${user_id}Astitva");
      final missing_people = await db
          .collection('users')
          .doc(user_id)
          .collection('missing people')
          .get();
      for (var person in missing_people.docs) {
        //print("${person.data()}ASTITVA");
        _missing.add(person.data());
      }
    }
    notifyListeners();
  }
}

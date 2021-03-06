import 'package:missing/globals.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MissingPeople with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _tensorDb = [];
  List<Map<String, dynamic>> _missing = [];
  List<Map<String, dynamic>> get missing => _missing;
  List<Map<String, dynamic>> get tensorDb => _tensorDb;

  Future<void> getPerUser() async {
    _missing.clear();
    Future.delayed(Duration(milliseconds: 100));
    final missing_peope = await db
        .collection('missing people')
        .where('user', isEqualTo: currentUid)
        .get();

    final x = missing_peope.docs;

    for (var a in x) {
      //print('${a.data()} AStitva');
      _missing.add(a.data());
    }
    notifyListeners();
  }

  Future<void> getAll() async {
    _missing.clear();
    Future.delayed(Duration(milliseconds: 100));
    final missing_people_ref = await db.collection('missing people').get();
    final missing_people = missing_people_ref.docs;
    for (var missing_peep in missing_people) {
      _missing.add(missing_peep.data());
    }
    notifyListeners();
  }

  Future<void> getTensorAll() async {
    _tensorDb.clear();
    Future.delayed(Duration(milliseconds: 100));
    final missing_people_ref = await db.collection('missing people').get();
    final missing_people = missing_people_ref.docs;
    for (var missing_peep in missing_people) {
      final temp = missing_peep.data();
      temp.update(
        'doc_ref',
        (value) => missing_peep.id,
        ifAbsent: () => missing_peep.id,
      );
      _tensorDb.add(temp);
    }
  }

  Future<void> refreshLocalDb() async {
    await getTensorAll();
  }

  Future<void> foundMissing(String doc_ref) async {
    await db
        .collection('missing people')
        .doc(doc_ref)
        .update({'missing': false});
  }

  Future<void> foundBy(String doc_ref) async {
    await db
        .collection('missing people')
        .doc(doc_ref)
        .update({'found_by': currentUid});
  }
}

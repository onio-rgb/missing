import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MissingList extends StatefulWidget {
  
  MissingList({Key? key,}) : super(key: key);

  @override
  State<MissingList> createState() => _MissingListState();
}

class _MissingListState extends State<MissingList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container()
    );
  }
}
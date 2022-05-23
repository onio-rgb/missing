import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:provider/provider.dart';

class MissingList extends StatefulWidget {
  MissingList({
    Key? key,
  }) : super(key: key);

  @override
  State<MissingList> createState() => _MissingListState();
}

class _MissingListState extends State<MissingList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String dropdownValue = "For Me";
  final missing = MissingPeople().addListener(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['For Me', 'All']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        body: FutureBuilder(
          future: ((dropdownValue == 'For Me')
              ? (context.read<MissingPeople>().getPerUser())
              : (context.read<MissingPeople>().getAll())),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Map<String, dynamic>> missing_people =
                  context.watch<MissingPeople>().missing;
              return ListView.builder(
                  itemCount: missing_people.length,
                  itemBuilder: (context, int i) {
                    return Text(
                        "${missing_people[i]['name']}  ${missing_people[i]['age']}");
                  });
            } else
              return CircularProgressIndicator();
          },
        ));
  }
}

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/screens/report_missing.dart';
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
        floatingActionButton: FloatingActionButton(
            isExtended: true,
            child: Icon(Icons.add,),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => ReportMissing())));
            }),
        appBar: AppBar(
          actions: [
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: FlexColor.greyLawLightPrimary,
              value: dropdownValue,
              icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.filter_list)),
              elevation: 16,
              style: const TextStyle(color: Colors.white),
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
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
          },
        ));
  }
}

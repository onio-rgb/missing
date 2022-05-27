import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missing/custom%20widgets/missing_card.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/screens/find_missing.dart';
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
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "h3",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportMissing())).then((value) {
                    setState(() {});
                  });
                },
                child: Icon(
                  Icons.add,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                  heroTag: "h4",
                  isExtended: true,
                  child: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FindMissing()))).then((value) {
                              setState(() {
                                
                              });
                            });
                  }),
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
                      return MissingCard(
                        name: missing_people[i]['name'],
                        age: missing_people[i]['age'],
                        image: missing_people[i]['image'],
                        lastwear: missing_people[i]['lastwear'],
                        feet: missing_people[i]['feet'],
                        inches: missing_people[i]['inches'],
                        missing: missing_people[i]['missing'],
                        lastloc: missing_people[i]['lastloc'],
                      );
                    });
              } else
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
            },
          )),
    );
  }
}

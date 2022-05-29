import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missing/custom%20widgets/missing_card.dart';
import 'package:missing/globals.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/providers/switch_screen.dart';
import 'package:missing/screens/drawer.dart';
import 'package:missing/screens/find_missing.dart';
import 'package:missing/screens/person_found_alert.dart';
import 'package:missing/screens/report_missing.dart';
import 'package:missing/screens/user_account_dialog.dart';
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

  List<Map<String, dynamic>> missing_people = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      print("${missing_people} alerdialogpls");

      for (var missing_peep in missing_people) {
        if (missing_peep['user'] == currentUid &&
            missing_peep['found_by'] != "" &&
            missing_peep['missing'] == true) {
          // print("alerdialogpls");
          Navigator.of(context)
              .restorablePush(_alertDialogBuilder, arguments: missing_peep);
        }
      }
    });
  }

  Widget build(BuildContext context) {
    var switchProvider = Provider.of<SwitchScreen>(context, listen: true);
    switchProvider.addListener(() {
      setState(() {});
    });

    return SafeArea(
      child: Scaffold(
          drawer: DrawerMain(),
          appBar: AppBar(
            elevation: 10,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).restorablePush(_dialogBuilder);
                    },
                    icon: Icon(Icons.person_outline_rounded)),
              )
            ],
          ),
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
                                builder: ((context) => FindMissing())))
                        .then((value) {
                      setState(() {});
                    });
                  }),
            ],
          ),
          body: FutureBuilder(
            future: ((switchProvider.state == "For Me")
                ? (context.read<MissingPeople>().getPerUser())
                : (context.read<MissingPeople>().getAll())),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                missing_people = context.watch<MissingPeople>().missing;

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
  

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => UserAccount(),
    );
  }

  static Route<Object?> _alertDialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => PersonFoundAlert(
        found_person: arguments as Map<String, dynamic>,
      ),
    );
  }
}

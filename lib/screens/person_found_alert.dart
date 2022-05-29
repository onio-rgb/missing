import 'package:flutter/material.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/providers/user_details.dart';
import 'package:provider/provider.dart';

class PersonFoundAlert extends StatefulWidget {
  final Map<String, dynamic> found_person;
  const PersonFoundAlert({Key? key, required this.found_person})
      : super(key: key);

  @override
  State<PersonFoundAlert> createState() => _PersonFoundAlertState();
}

class _PersonFoundAlertState extends State<PersonFoundAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () async {
              await context
                  .read<MissingPeople>()
                  .foundMissing(widget.found_person['doc_ref']);
              
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 17),
            ))
      ],
      content: Container(
        height: 300,
        child: FutureBuilder(
            future: context
                .read<UserDetails>()
                .getUser(widget.found_person['found_by']),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "${widget.found_person['name']} has been found by : ${snapshot.data!['name']}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please Contact him/her on phone/email : ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${snapshot.data!['phone']}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "OR",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${snapshot.data!['email']}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

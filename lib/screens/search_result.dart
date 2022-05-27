import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:missing/custom%20widgets/missing_card.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/providers/user_details.dart';
import 'package:missing/services/face_auth.dart';
import 'package:missing/services/facerecognition.dart';
import 'package:missing/services/get_image.dart';
import 'package:missing/services/mobilenet.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  final File image;
  final List<Face> faces;
  const SearchResult({Key? key, required this.image, required this.faces})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  FaceAuthentication faceAuthentication = FaceAuthentication();
  Map<String, dynamic> matched_person = {};
  List _mobilenet_res = [];
  MobileNet mobileNet = new MobileNet();

  Future<Map<String, dynamic>> findTraits() async {
    for (var face in widget.faces) {
      _mobilenet_res = (await mobileNet.predict(widget.image, face));
    }
    print(_mobilenet_res);
    Map<String, dynamic> matching_person =
        await faceAuthentication.compare(_mobilenet_res, context);
    if (matching_person.isEmpty == false) {
      context.read<MissingPeople>().foundMissing(matching_person['doc_ref']);
    }
    return matching_person;
  }

  @override
  Widget build(BuildContext context) {
    // print("showing result");
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Future.wait([
          findTraits(),
          context.read<UserDetails>().getUser(matched_person['user'])
        ]),
        builder: (ct, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty == false) {
              matched_person = snapshot.data![0];
              return Column(children: [
                Container(
                    width: double.infinity,
                    child: MissingCard(
                        name: snapshot.data![0]['name'],
                        age: snapshot.data![0]['age'],
                        image: snapshot.data![0]['image'],
                        lastwear: snapshot.data![0]['lastwear'],
                        feet: snapshot.data![0]['feet'],
                        inches: snapshot.data![0]['inches'],
                        missing: false,
                        lastloc: snapshot.data![0]['lastloc'])),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Text(
                            "This Person was reported missing by ${snapshot.data![1]['name']}"),
                        Text("Please Contact him/her on this number / email "),
                        Text(
                          "${snapshot.data![1]['phone']}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        Text("Or"),
                        Text(
                          "${snapshot.data![1]['email']}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )
                      ]),
                    ),
                  ),
                )
              ]);
            } else
              return Text('face not found');
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

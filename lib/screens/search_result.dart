import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:missing/custom%20widgets/missing_card.dart';
import 'package:missing/globals.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/providers/user_details.dart';
import 'package:missing/services/face_auth.dart';
import 'package:missing/services/facerecognition.dart';
import 'package:missing/services/get_image.dart';
import 'package:missing/services/mobilenet.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<Map<String, dynamic>> findTraits(BuildContext context) async {
    for (var face in widget.faces) {
      _mobilenet_res = (await mobileNet.predict(widget.image, face));
    }
    print(_mobilenet_res);
    Map<String, dynamic> matching_person =
        await faceAuthentication.compare(_mobilenet_res, context);
    if (matching_person.isEmpty == false) {
      context.read<MissingPeople>().foundBy(matching_person['doc_ref']);
    }
    return matching_person;
  }

  @override
  Widget build(BuildContext context) {
    // print("showing result");
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: 400,
                child: Card(
                  child: Image.file(
                    widget.image,
                  ),
                )),
          ),
          FutureBuilder(
            future: findTraits(context),
            builder: (ct, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.isEmpty == false) {
                  matched_person = snapshot.data!;
                  return Column(children: [
                    Container(
                        width: double.infinity,
                        child: MissingCard(
                            name: snapshot.data!['name'],
                            age: snapshot.data!['age'],
                            image: snapshot.data!['image'],
                            lastwear: snapshot.data!['lastwear'],
                            feet: snapshot.data!['feet'],
                            inches: snapshot.data!['inches'],
                            missing: snapshot.data!['missing'],
                            lastloc: snapshot.data!['lastloc'])),
                    FutureBuilder(
                        future: context
                            .read<UserDetails>()
                            .getUser(matched_person['user']),
                        builder: ((ctt,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(children: [
                                    Text(
                                        "This Person was reported missing by ${snapshot.data!['name']}"),
                                    Text(
                                        "Please Contact him/her on this number / email "),
                                    Text(
                                      "${snapshot.data!['phone']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                    Text("Or"),
                                    Text(
                                      "${snapshot.data!['email']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          } else
                            return Center(
                              child: SpinKitCircle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                        }))
                  ]);
                } else
                  return Center(
                    child: Text(
                      'FACE NOT FOUND IN DATABASE',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  );
              } else
                return Center(
                  child: SpinKitCircle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}

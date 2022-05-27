import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:missing/custom%20widgets/missing_card.dart';
import 'package:missing/providers/missing_people.dart';
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
        future: findTraits(),
        builder: (ct, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty == false) {
              return ListView(children: [
                Container(
                    width: double.infinity,
                    child: MissingCard(
                        name: snapshot.data!['name'],
                        age: snapshot.data!['age'],
                        image: snapshot.data!['image'],
                        lastwear: snapshot.data!['lastwear'],
                        feet: snapshot.data!['feet'],
                        inches: snapshot.data!['inches'],
                        missing: false,
                        lastloc: snapshot.data!['lastloc'])),
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

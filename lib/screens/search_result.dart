import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:missing/services/face_auth.dart';
import 'package:missing/services/facerecognition.dart';
import 'package:missing/services/get_image.dart';
import 'package:missing/services/mobilenet.dart';

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
    Map<String, dynamic> matching_person = await faceAuthentication.compare(_mobilenet_res, context);
    return matching_person;
  }

  @override
  Widget build(BuildContext context) {
    // print("showing result");
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: findTraits(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty == false) {
              return ListView(children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(snapshot.data!['image']),
                ),
                Text(snapshot.data!['name'])
              ]);
            } else
              return Text('face not found');
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

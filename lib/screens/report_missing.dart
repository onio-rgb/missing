import 'dart:ffi';
import 'dart:io';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:missing/custom%20widgets/textfield.dart';
import 'package:missing/globals.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:missing/screens/missing_people_list.dart';
import 'package:missing/services/facerecognition.dart';
import 'package:missing/services/get_image.dart';
import 'package:missing/services/mobilenet.dart';

class ReportMissing extends StatefulWidget {
  const ReportMissing({Key? key}) : super(key: key);

  @override
  State<ReportMissing> createState() => _ReportMissingState();
}

class _ReportMissingState extends State<ReportMissing> {
  bool _multiplefaces = false;
  List _mobilenet_res = [];
  List<Face> _faces = [];
  bool _noface = false;
  File? _image;
  //function to pick photo from either gallery or camera

  // Future getImage(bool gallery) async {
  //   ImagePicker picker = ImagePicker();
  //   PickedFile pickedFile;
  //   // Let user select photo from gallery
  //   if (gallery) {
  //     // ignore: deprecated_member_use
  //     pickedFile = (await picker.getImage(
  //       source: ImageSource.gallery,
  //     ))!;
  //   }
  //   // Otherwise open camera to get new photo
  //   else {
  //     // ignore: deprecated_member_use
  //     pickedFile = (await picker.getImage(
  //       source: ImageSource.camera,
  //     ))!;
  //   }

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       //print("${_image!.path} Astitba");
  //     } else {
  //       _image = null;
  //       print('No image selected.');
  //     }
  //   });
  // }

  Future<String> uploadFile(File image) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref('missing/${image.path.split('/').last}');

      await storageRef.putFile(image).then((p0) {
        print('File Uploaded');
      });

      String returnURL = await storageRef.getDownloadURL();
      return returnURL;
    } on Exception catch (e) {
      print("${e} Very");
    }
    return "";
  }

  Future<void> saveImages(DocumentReference ref) async {
    // print("bery");
    String imageURL = await uploadFile(_image!);
    print("bery");
    print("${imageURL} Astitba ");
    ref.update({"image": imageURL});
  }

  Future<void> uploadTensor(DocumentReference ref) async {
    await ref.update({"tensor": _mobilenet_res});
  }

  MobileNet mobileNet = MobileNet();
  FaceRecognition faceRecognition = FaceRecognition();
  GetImage getImage = GetImage();
  MissingPeople missingPeople = MissingPeople();
  final db = FirebaseFirestore.instance;
  late TextEditingController name = TextEditingController();
  late TextEditingController age = TextEditingController();
  late TextEditingController lastwear = TextEditingController();
  late TextEditingController feet = TextEditingController();
  late TextEditingController inches = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "h1",
          onPressed: () async {
            _mobilenet_res.clear();
            setState(() {
              _noface = false;
              _multiplefaces = false;
            });
            _image = await getImage.getImage(true);
            if (_image != null) {
              _faces = await faceRecognition.detectFaces(_image!);
              if (_faces.length == 0) {
                setState(() {
                  _noface = true;
                });
              } else if (_faces.length > 1) {
                setState(() {
                  _multiplefaces = true;
                });
              } else {
                setState(() {});
              }

              for (var face in _faces) {
                _mobilenet_res = (await mobileNet.predict(_image!, face));
              }
              print(_mobilenet_res);
              setState(() {});
            }
          },
          child: Icon(Icons.photo),
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          heroTag: "h2",
          onPressed: () async {
            _mobilenet_res.clear();
            setState(() {
              _noface = false;
              _multiplefaces = false;
            });
            _image = await getImage.getImage(false);
            if (_image != null) {
              _faces = await faceRecognition.detectFaces(_image!);
              if (_faces.length == 0) {
                setState(() {
                  _noface = true;
                });
              }
              if (_faces.length > 1) {
                setState(() {
                  _multiplefaces = true;
                });
              }

              for (var face in _faces) {
                _mobilenet_res = (await mobileNet.predict(_image!, face));
              }
              print(_mobilenet_res);
              setState(() {});
            }
          },
          child: Icon(Icons.camera),
        )
      ]),
      appBar: AppBar(),
      body: ListView(
        children: [
          CustomTextField(
            label: 'Name',
            input: name,
            maxline: 1,
            width: double.infinity,
            icon: Icons.password,
            hasIcon: false,
          ),
          CustomTextField(
            label: 'Age',
            input: age,
            maxline: 1,
            width: double.infinity,
            icon: Icons.password,
            hasIcon: false,
          ),
          CustomTextField(
            label: 'Last seen clothes',
            input: lastwear,
            maxline: 2,
            width: double.infinity,
            icon: Icons.password,
            hasIcon: false,
          ),
          Row(
            children: [
              CustomTextField(
                label: 'Feet',
                input: feet,
                maxline: 1,
                width: 150,
                icon: Icons.password,
                hasIcon: false,
              ),
              CustomTextField(
                label: 'Inches',
                input: inches,
                maxline: 1,
                width: 150,
                icon: Icons.password,
                hasIcon: false,
              ),
            ],
          ),
          (_noface == true)
              ? Text(
                  "No Face Detected! Try again",
                  textAlign: TextAlign.center,
                )
              : Container(),
          (_multiplefaces == true)
              ? Text(
                  "More than once face detected",
                  textAlign: TextAlign.center,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Container(
                width: 300,
                height: 400,
                child: (_image != null)
                    ? Image.file(
                        _image!,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AsyncButtonBuilder(
                  onPressed: () async {
                    final details = {
                      'user': currentUid,
                      'name': name.text,
                      'age': age.text,
                      'lastwear': lastwear.text,
                      'feet': int.parse(feet.text),
                      'inches': int.parse(inches.text)
                    };
                    DocumentReference doc_ref =
                        await db.collection('missing people').add(details);
                    // print("bery");
                    await saveImages(doc_ref);
                    await uploadTensor(doc_ref);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 17),
                  ),
                  builder: (context, child, callback, _) {
                    return ElevatedButton(onPressed: callback, child: child);
                  },
                ),
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}

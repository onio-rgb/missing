import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:missing/screens/search_result.dart';
import 'package:missing/services/face_auth.dart';
import 'package:missing/services/facerecognition.dart';
import 'package:missing/services/get_image.dart';
import 'package:missing/services/image_processing.dart';
import 'package:missing/services/mobilenet.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FindMissing extends StatefulWidget {
  const FindMissing({Key? key}) : super(key: key);

  @override
  State<FindMissing> createState() => _FindMissingState();
}

class _FindMissingState extends State<FindMissing> {
  bool _isLoaderVisible = false;
  File? _image;
  List<Face> _faces = [];
  bool _noface = false;
  bool _multiplefaces = false;
  FaceRecognition faceRecognition = FaceRecognition();
  GetImage getImage = GetImage();
  // FaceAuthentication faceAuthentication = FaceAuthentication();
  // Map<String, dynamic> matching_person = {};
  // bool _noface = false;
  // bool _multiplefaces = false;
  // List _mobilenet_res = [];
  // File? _image = null;
  // List<Face> _faces = [];
  // FaceRecognition faceRecognition = FaceRecognition();
  // GetImage getImage = GetImage();
  // MobileNet mobileNet = new MobileNet();
  bool _imagepicked = false;
  FaceDetectorOptions options =
      FaceDetectorOptions(enableLandmarks: false, enableClassification: true);
  ImagePicker picker = ImagePicker();
  //late File _image;
  bool _chosegallery = false;
  //function to pick photo from either gallery or camera

  // Future getImage(bool gallery) async {
  //   ImagePicker picker = ImagePicker();
  //   XFile pickedFile;
  //   // Let user select photo from gallery
  //   if (gallery) {
  //     // ignore: deprecated_member_use
  //     pickedFile = (await picker.pickImage(
  //       source: ImageSource.gallery,
  //     ))!;
  //   }
  //   // Otherwise open camera to get new photo
  //   else {
  //     // ignore: deprecated_member_use
  //     pickedFile = (await picker.pickImage(
  //       source: ImageSource.camera,
  //     ))!;
  //   }

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       _imagepicked = true;
  //       //print("${_image!.path} Astitba");
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // void detectFaces(File image) async {
  //   print("detecting faces");
  //   FaceDetector _faceDetector = FaceDetector(options: options);
  //   final inputImage = InputImage.fromFile(_image);
  //   List<Face> faces = [];
  //   try {
  //     faces = await _faceDetector.processImage(inputImage);
  //   } on Exception catch (e) {
  //     print("${e} Astitva1");
  //   }
  //   print("${faces.length} Astitva");
  //   for (Face face in faces) {
  //     print(await mobileNet.predict(image, face));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () async {
                _image = await getImage.getImage(false);
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
                  }
                  print("showing result");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchResult(image: _image!, faces: _faces)));
                }
              },

              //   for (var face in _faces) {
              //     _mobilenet_res = (await mobileNet.predict(_image!, face));
              //   }
              //   print(_mobilenet_res);
              //   setState(() {});
              // }
              // },
              child: Text("Camera")),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
              onPressed: () async {
                _image = await getImage.getImage(true);
                if (_image != null) {
                  context.loaderOverlay.show(widget: FindMissing());

                  _faces = await faceRecognition.detectFaces(_image!);

                  context.loaderOverlay.hide();

                  if (_faces.length == 0) {
                    setState(() {
                      _noface = true;
                    });
                  } else if (_faces.length > 1) {
                    setState(() {
                      _multiplefaces = true;
                    });
                  }
                  print("showing result");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchResult(image: _image!, faces: _faces)));
                }
              },
              child: Text('Gallery'))
        ]),
      ),
    );
  }
}

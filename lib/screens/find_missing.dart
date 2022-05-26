import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:missing/services/image_processing.dart';
import 'package:missing/services/mobilenet.dart';

class FindMissing extends StatefulWidget {
  const FindMissing({Key? key}) : super(key: key);

  @override
  State<FindMissing> createState() => _FindMissingState();
}

class _FindMissingState extends State<FindMissing> {
  MobileNet mobileNet = new MobileNet();
  bool _imagepicked = false;
  FaceDetectorOptions options =
      FaceDetectorOptions(enableLandmarks: false, enableClassification: true);
  ImagePicker picker = ImagePicker();
  late File _image;
  bool _chosegallery = false;
  //function to pick photo from either gallery or camera

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      // ignore: deprecated_member_use
      pickedFile = (await picker.pickImage(
        source: ImageSource.gallery,
      ))!;
    }
    // Otherwise open camera to get new photo
    else {
      // ignore: deprecated_member_use
      pickedFile = (await picker.pickImage(
        source: ImageSource.camera,
      ))!;
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagepicked = true;
        //print("${_image!.path} Astitba");
      } else {
        print('No image selected.');
      }
    });
  }

  void detectFaces(File image) async {
    print("detecting faces");
    FaceDetector _faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(_image);
    List<Face> faces = [];
    try {
      faces = await _faceDetector.processImage(inputImage);
    } on Exception catch (e) {
      print("${e} Astitva1");
    }
    print("${faces.length} Astitva");
    for (Face face in faces) {
      print(await mobileNet.predict(image, face));
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () async {
                await getImage(false);
                if (_imagepicked) {
                  detectFaces(_image);
                }
              },
              child: Text("Camera")),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
              onPressed: () async {
                await getImage(true);
                if (_imagepicked) {
                  detectFaces(_image);
                }
              },
              child: Text('Gallery'))
        ]),
      ),
    );
  }
}

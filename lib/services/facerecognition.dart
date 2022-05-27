import 'dart:io';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:missing/services/mobilenet.dart';
import 'package:missing/services/image_processing.dart';

class FaceRecognition {
  MobileNet mobileNet = MobileNet();

  FaceDetectorOptions options = FaceDetectorOptions(
      enableClassification: true, performanceMode: FaceDetectorMode.accurate);

  Future<List<Face>> detectFaces(File image) async {
    print("detecting faces");
    FaceDetector _faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(image);
    List<Face> faces = [];
    try {
      faces = await _faceDetector.processImage(inputImage);
    } on Exception catch (e) {
      print("${e} Astitva1");
    }
    print("${faces.length} Astitva");

    return faces;
    // for (Face face in faces) {
    //   print(await mobileNet.predict(image, face));
    // }
  }
}

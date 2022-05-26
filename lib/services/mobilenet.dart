import 'dart:io';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:missing/services/image_processing.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MobileNet {
  Interpreter? _interpreter = null;

  //initialize the tflite and load the mobilenet model for use
  //this function is called after initializing the mobilenet class
  Future<void> initialize() async {
    late Delegate delegate;
    try {
      if (Platform.isAndroid) {
        delegate = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
            isPrecisionLossAllowed: false,
            inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
            inferencePriority1: TfLiteGpuInferencePriority.minLatency,
            inferencePriority2: TfLiteGpuInferencePriority.auto,
            inferencePriority3: TfLiteGpuInferencePriority.auto,
          ),
        );
      } else if (Platform.isIOS) {
        delegate = GpuDelegate(
          options: GpuDelegateOptions(
              allowPrecisionLoss: true,
              waitType: TFLGpuDelegateWaitType.active),
        );
      }
      var interpreterOptions = InterpreterOptions()..addDelegate(delegate);

      _interpreter = await Interpreter.fromAsset('mobilefacenet.tflite',
          options: interpreterOptions);
    } catch (e) {
      print("${e} Astitva2");
    }
  }

  Future<List> predict(File image, Face face) async{
    if (_interpreter == null) await this.initialize();
    ImageProcess imageProcess = new ImageProcess();
    if (_interpreter == null) throw Exception('Interpreter is null');
    if (face == null) throw Exception('Face is null');

    // get the cropped image as vector(Float32) for RGB
    List<dynamic> input = imageProcess.process(image, face);

    //convert to 3D array 112 denote the number of pixel width and height
    //3 denote 3 channels - > RGB
    input = input.reshape([1, 112, 112, 3]);

    //generate 2D list to store output.
    List output = List.generate(1, (index) => List.filled(192, 0));

    // run the input vector through the mobilenet model
    _interpreter?.run(input, output);

    //reshape the output so that it is 1D
    output = output.reshape([192]);

    return List.from(output);
  }
}

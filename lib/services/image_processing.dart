import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as imglib;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ImageProcess {
  imglib.Image _crop(File _image, Face face) {
    imglib.Image? _convertedImage = imglib.decodeJpg(_image.readAsBytesSync());

    double x = face.boundingBox.left - 10.0;
    double y = face.boundingBox.top - 10.0;
    double w = face.boundingBox.width + 10.0;
    double h = face.boundingBox.height + 10.0;
    imglib.Image temp = imglib.copyCrop(
        _convertedImage!, x.round(), y.round(), w.round(), h.round());

    imglib.Image? _cropped = imglib.copyResizeCropSquare(temp, 112);
    return _cropped;
  }

  List process(File image, Face face) {
    imglib.Image _croppedImage = _crop(image, face);
    Float32List _imagedatalist = imageToByteListFloat32(_croppedImage);
    return _imagedatalist;
  }

  Float32List imageToByteListFloat32(imglib.Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }
}

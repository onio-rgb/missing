import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GetImage {
  bool _imagepicked = false;
  ImagePicker picker = ImagePicker();
  late File _image;
  bool _chosegallery = false;

  //function to pick photo from either gallery or camera

  Future<File?> getImage(bool gallery) async {
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

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _imagepicked = true;
      return _image;
      //print("${_image!.path} Astitba");
    } else {
      return null;
      print('No image selected.');
    }
  }
}

import 'package:image_picker/image_picker.dart';

class ImageModel {

  final ImagePicker _picker = ImagePicker();

  getMultiXFile() async {
    try{
      return await _picker.pickMultiImage();
    }catch(e){
      return null;
    }
  }

}
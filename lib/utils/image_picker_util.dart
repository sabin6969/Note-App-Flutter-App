import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static ImagePicker imagePicker = ImagePicker();
  static Future<XFile?> pickImageFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}

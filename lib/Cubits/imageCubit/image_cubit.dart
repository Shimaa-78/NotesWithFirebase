import 'dart:convert';

import 'dart:io';  // Used for mobile platform
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());
  File? selectedImage; // Selected image file

  Future<void> pickImage() async {
    emit(ImagePickLoading());

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }

    emit(ImagePickSuccess());
  }

  String? encodeImageToBase64(File? image) {
    if (image != null) {
      final bytes = image.readAsBytesSync();
      return base64Encode(bytes); // Convert image to Base64 string
    }
    return null;
  }
}

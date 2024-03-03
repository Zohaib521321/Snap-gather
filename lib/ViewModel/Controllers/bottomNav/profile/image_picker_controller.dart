import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Functions/compress_image.dart';
import '../../../Functions/snack_bar.dart';
class ImagePickerController extends GetxController{
  //images
  XFile? compressedImage;//compress
  RxString pickGalleryImage="".obs;
  //pick image
  void pickImage()async {

    try{
      final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickImage != null) {
        pickGalleryImage.value = pickImage.path;

        final compressedImage = await ImageUtils.compressImage(
            File(pickGalleryImage.value));

        if (compressedImage != null) {
          // Use compressedImage as needed
          this.compressedImage = compressedImage;
          MessageUtils.showSuccessSnackBar(
              "Success", "Image Picked and Compressed Successfully");
        }
      }
      else{
        MessageUtils.showErrorSnackBar("Error", "Image Not picked");
      }
    }
    catch(e){
      throw e.toString();
    }
  }
  @override
  void onClose() {
    // Close and release resources
    print("Closing ImagePickerController");
    pickGalleryImage.close();
    super.onClose();
  }

}
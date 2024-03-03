import 'dart:io';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/show_dialogue.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Functions/compress_image.dart';
import '../../../Functions/database_utils.dart';
class EditProfileController extends GetxController{
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController majorController=TextEditingController();
  final TextEditingController roleController=TextEditingController();
  final TextEditingController bioController=TextEditingController();
  final  editProfileKey = GlobalKey<FormState>();
//images
  XFile? compressedImage;//compress
  RxString pickGalleryImage="".obs;
  //pick image
  void pickImage()async {

    try{
      final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickImage != null) {
        pickGalleryImage.value = pickImage.path;
        update();
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
  //show Dialogue
  void profilePickingDialogue(BuildContext context){
    DialogueUtils.confirmationDialogue("Pick Image", Column(
      children: [
             InkWell(
                onTap: (){
                  pickImage();
                },
                child: Container(
                    width: context.width*0.40,
                    height: context.width*0.30,
                    decoration: BoxDecoration(
                      color: ColorUtils.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:Obx(() => pickGalleryImage.value==""? Center(
                      child: Image.asset(ImagePathUtils.imageIcon),
                    ):Image.file(File(pickGalleryImage.value)))
                ),
              ),

       const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(onPressed: (){
              NavigationUtils.pagePop();
            }, title: "Cancel", imagePath: ImagePathUtils.cancel,
                color: ColorUtils.redShade),
            PrimaryButton(onPressed: ()async{
              String imageUrl=await DatabaseUtils.
              uploadToDatabase(File(compressedImage!.path));
              CollectionUtils.userDataCollection.doc(FirebaseAuth
                  .instance.currentUser!.uid).update({
                "imageUrl":imageUrl,
              });
              NavigationUtils.pagePop();
              NavigationUtils.pagePop();
              pickGalleryImage.value="";
            }, title: "Confirm", imagePath: ImagePathUtils.save,
                color: ColorUtils.blueShade)

          ],
        )
      ],
    ));
  }
  //press Function
  void onPressed(){
    if(editProfileKey.currentState!.validate()&& pickGalleryImage.isNotEmpty){
      MessageUtils.showSuccessSnackBar("Success", "Valid Successfully");

    }
    else{
      if(pickGalleryImage.isEmpty){
        MessageUtils.showErrorSnackBar("Error",
            "Please Pick image First");
      }
      else{
        MessageUtils.showErrorSnackBar("Error",
            "Please fill all required fields");
      }
    }

  }

  @override
  void onClose() {
    // Dispose of text controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    majorController.dispose();
    roleController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
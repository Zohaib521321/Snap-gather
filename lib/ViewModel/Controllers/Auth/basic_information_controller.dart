import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Functions/compress_image.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
class BasicInformationController extends GetxController{

  final TextEditingController nameController=TextEditingController();
  final TextEditingController majorController=TextEditingController();
  final TextEditingController roleController=TextEditingController();
  final TextEditingController bioController=TextEditingController();
  final TextEditingController dateOfBirthController=TextEditingController();
   //form key
  final  basicInformationKey = GlobalKey<FormState>();
  RxString imagePath="".obs;
  XFile? compressedImage;
  DateTime? selectedDate;
  RxBool loading=false.obs;
  void setLoading(bool value){
    loading.value=value;
  }
  //date of birth
  void dateOfBirthDialogue(BuildContext context) async{
    DateTime? dateTime=await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime(1900),
        lastDate: DateTime.now(),
      builder: (BuildContext context,child){
      return Theme(data: ThemeData.light().copyWith(
        colorScheme:const ColorScheme.light(
          primary: ColorUtils.redShade
        )
      ), child: child!);
      }
    );
    if(dateTime!=null){
       selectedDate=DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      );
      String formattedDate=DateFormat("dd/MM/yyyy").format(selectedDate??DateTime.now());
      dateOfBirthController.text=formattedDate;
    }
  }
  //image picker
  void imagePicker()async{
    try{
      final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery,);
      if (pickImage == null) {
        // User canceled image picking
        MessageUtils.showErrorSnackBar("Error", "Image picking canceled");
        return;
      }
      imagePath.value=pickImage.path;
      final compressedImage=await ImageUtils.compressImage(File(imagePath.value));
      if(compressedImage!=null){
        this.compressedImage=compressedImage;
        MessageUtils.showSuccessSnackBar(
            "Success", "Image Picked Successfully");
      }
      else {
        MessageUtils.showErrorSnackBar("Error", "ImageNot picked");
      }
    }
catch(e){
  MessageUtils.showErrorSnackBar("Error", "An unexpected error occurred");
}
  }
  //Upload to firestore
  Future<void> uploadToDataBase()async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
   String imageUrl=await DatabaseUtils.uploadToDatabase(File(compressedImage!.path));
   try {
     setLoading(true);
     await DatabaseUtils.requestServer(() async {
       await CollectionUtils.userDataCollection
           .doc(uid).update({
         "name": nameController.text.toString(),
         "dateOfBirth": selectedDate,
         "joinDate": DateTime.now(),
         "major": majorController.text.toString(),
         "role": roleController.text.toString(),
         "bio": bioController.text.toString(),
         "uid": uid,
         "imageUrl": imageUrl,
         "dobString": dateOfBirthController.text.toString(),
       });
     });
   }
   finally{
     setLoading(false);
   }
   }
  //on pressed
  void onClick()async{
    if(basicInformationKey.currentState!.validate()&&imagePath.isNotEmpty){
      MessageUtils.showSuccessSnackBar("Success", "Fields are valid");
      await uploadToDataBase();
      Get.delete<BasicInformationController>();
      NavigationUtils.popUntilNav();
    }
    else{
      if(imagePath.isEmpty){
        MessageUtils.showSuccessSnackBar("Sorry", "Please pick Image first");
      }
      else{
        MessageUtils.showErrorSnackBar("Error", "Please fill all fields");
      }
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    debugPrint("Closing Controller");
    // Dispose to prevent memory leaks
   nameController.dispose();
   bioController.dispose();
   majorController.dispose();
   roleController.dispose();
   dateOfBirthController.dispose();
    super.onClose();
  }
}
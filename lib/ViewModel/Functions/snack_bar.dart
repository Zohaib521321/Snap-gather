import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MessageUtils{
  static void showSuccessSnackBar(String title,String message){
    Get.snackbar(title,
      message,
      icon: Image.asset(ImagePathUtils.save),
      titleText: Text(title,style: StyleUtils.whiteHeading,),
      messageText:Text(message,style: StyleUtils.whiteW400,),
      backgroundColor: ColorUtils.blueShade,
      animationDuration: const Duration(seconds: 1),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  static void showErrorSnackBar(String title,String message){
    Get.snackbar(title,
      message,
      duration:const Duration(seconds: 3),
      icon: Image.asset(ImagePathUtils.cancel),
      titleText: Text(title,style: StyleUtils.whiteHeading,),
      messageText:Text(message,style: StyleUtils.whiteW400,),
      backgroundColor: ColorUtils.redShade,
      boxShadows: [
        const BoxShadow(
          blurRadius: 4,
          spreadRadius: 3,
          color: ColorUtils.pinkShade,
          offset: Offset(3, 0),

        )
      ],
      animationDuration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DialogueUtils{
 static void confirmationDialogue(String title,Widget content){
    Get.defaultDialog(
      title: title,
      titleStyle: StyleUtils.titleHeading,

      content: content,
      radius: 12,
    );

  }
 static void exitDialogue(String title,Widget content,
    String actionTitle,String actionImage,Color color,VoidCallback onTap){
   Get.defaultDialog(
     title: title,
     titleStyle: StyleUtils.titleHeading,
     content: content,
     radius: 12,
     actions: [
       PrimaryButton(onPressed: (){
         NavigationUtils.pagePop();
       }, title: "Cancel",
           imagePath: ImagePathUtils.cancel,
           color: ColorUtils.lightGrey),
       PrimaryButton(onPressed: onTap,
           title: actionTitle, imagePath: actionImage,
           color: color)
     ]
   );

 }
 static void loading(){
   Get.defaultDialog(
     title: "Loading",
     content:const CircularProgressIndicator(
       color: ColorUtils.blueShade,
       backgroundColor: ColorUtils.redShade,
     )
   );
 }

}
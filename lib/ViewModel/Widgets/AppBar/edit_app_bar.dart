import 'dart:io';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/profile/edit_profile_controllers.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/leading.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppStrings/database_collection.dart';
import '../../Functions/database_utils.dart';
import '../../Functions/show_dialogue.dart';
class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String imageUrl;
  const EditAppBar({super.key, required this.title,
    required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final controller=Get.find<EditProfileController>();
    return  AppBar(
        elevation: 10,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))
        ),
        backgroundColor: ColorUtils.whiteColor,
        title: Text(
          title,
          style: StyleUtils.titleHeading,
        ),
        leading:const Leading(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Column(
            children: [
              GetBuilder<EditProfileController>
                (
                  init: EditProfileController(),
                  builder: (controller){
                return CircleAvatar(
                  backgroundColor: ColorUtils.pinkShade,
                  radius: 40,
                  backgroundImage:imageUrl.isNotEmpty
                      ?NetworkImage(imageUrl)
                      : null,
                );
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(14,0,14,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      PrimaryButton(
                          onPressed: () async{
                            controller.profilePickingDialogue(context);
                          },
                          title: "Change",
                          imagePath: ImagePathUtils.edit,
                          color: ColorUtils.blueShade),
                     const Spacer(),
                      PrimaryButton(
                          onPressed: () {
                            DialogueUtils.exitDialogue("Remove Image",
                                const Text("Do you want to Remove Image?"),
                                "Remove", ImagePathUtils.delete,
                                ColorUtils.redShade, () async{
                                  CollectionUtils.userDataCollection.doc(FirebaseAuth
                                      .instance.currentUser!.uid).update({
                                    "imageUrl":"",
                                  });
                                  NavigationUtils.pagePop();
                                  NavigationUtils.pagePop();
                                });

                          },
                          title: "Remove",
                          imagePath: ImagePathUtils.delete,
                          color: ColorUtils.redShade),
                    ],
                  ),
              ),

              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 170);
}

import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/profile/edit_profile_controllers.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:event_management/ViewModel/Functions/validate_form.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/edit_app_bar.dart';
import 'package:event_management/ViewModel/Widgets/textField/search_field.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ViewModel/AppStrings/app_colors.dart';
import '../../../../ViewModel/AppStrings/image_path.dart';
import '../../../../ViewModel/Functions/show_dialogue.dart';
import '../../../../ViewModel/Widgets/Button/primary.dart';

class EditProfileMain extends StatelessWidget {
  final UserModel data;
  const EditProfileMain({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditAppBar(
        title: "Edit Profile",
        imageUrl: data.imageUrl,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<EditProfileController>(
                init: EditProfileController(),
                builder: (textFieldControllers) {
                  textFieldControllers.nameController.text = data.name;
                  textFieldControllers.majorController.text = data.major;
                  textFieldControllers.roleController.text = data.role;
                  textFieldControllers.bioController.text = data.bio;
                  return Form(
                      key: textFieldControllers.editProfileKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Basic Information",
                            style: StyleUtils.titleHeading,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Name",
                                style: StyleUtils.description,
                              )),
                          SearchField(
                              validator: ValidationUtils.validateLengthRange(
                                  "Name", 4,
                                  maxLength: 15),
                              label: "Name",
                              controller: textFieldControllers.nameController),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Major",
                                style: StyleUtils.description,
                              )),
                          SearchField(
                              validator: ValidationUtils.validateLengthRange(
                                  "Major", 5,
                                  maxLength: 22),
                              label: "Your field i.e. Software engineering",
                              controller: textFieldControllers.majorController),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Role",
                                style: StyleUtils.description,
                              )),
                          SearchField(
                              validator: ValidationUtils.validateLengthRange(
                                  "Role", 4,
                                  maxLength: 15),
                              label: "Your i.e. Personal",
                              controller: textFieldControllers.roleController),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Bio",
                                style: StyleUtils.description,
                              )),
                          SearchField(
                              validator: ValidationUtils.validateLengthRange(
                                  "Bio", 20,
                                  maxLength: 180),
                              multiLine: true,
                              keyboard: TextInputType.multiline,
                              label: "Your i.e. Hello I am.....",
                              controller: textFieldControllers.bioController),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryButton(
                                    onPressed: () {},
                                    title: "Discard",
                                    imagePath: ImagePathUtils.cancel,
                                    color: ColorUtils.greyShade),
                                const Spacer(),
                                PrimaryButton(
                                    onPressed: () {
                                      textFieldControllers.onPressed();
                                    },
                                    title: "Save",
                                    imagePath: ImagePathUtils.save,
                                    color: ColorUtils.blueShade),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Delete account",
                                style: StyleUtils.titleHeading,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                    onPressed: () {
                                      DialogueUtils.exitDialogue(
                                          "Delete Account",
                                          const Text(
                                              "Deleting your account also deletes your events"
                                              " and cannot be undone."),
                                          "Delete",
                                          ImagePathUtils.delete,
                                          ColorUtils.redShade, () {
                                        FirebaseAuth.instance.currentUser
                                            ?.delete();
                                        MessageUtils.showSuccessSnackBar(
                                            "Deleted", "Account deleted");
                                        NavigationUtils.popUntilSignup();
                                      });
                                    },
                                    title: "Delete account",
                                    imagePath: ImagePathUtils.delete,
                                    color: ColorUtils.redShade),
                              ),
                            ],
                          ),
                        ],
                      ));
                })),
      ),
    );
  }
}

import 'dart:io';
import 'package:event_management/ViewModel/Controllers/Auth/basic_information_controller.dart';
import 'package:event_management/ViewModel/Functions/validate_form.dart';
import 'package:event_management/ViewModel/Widgets/textField/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/AppStrings/app_colors.dart';
import '../../ViewModel/AppStrings/image_path.dart';
import '../../ViewModel/AppStrings/text_style.dart';
import '../../ViewModel/Widgets/Button/primary.dart';
class BasicInformation extends StatelessWidget {
  const BasicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldControllers=Get.find<BasicInformationController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Information"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(

          child: Form(
            key: textFieldControllers.basicInformationKey,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    textFieldControllers.imagePicker();
                  },
                  child: Container(
                      width: context.width*0.40,
                      height: context.width*0.30,
                      decoration: BoxDecoration(
                        color: ColorUtils.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:Obx(() =>textFieldControllers.imagePath.value==""? Center(
                        child: Image.asset(ImagePathUtils.imageIcon),
                      ):Image.file(File(textFieldControllers.imagePath.value)))
                  ),
                ),
                const SizedBox(height: 8,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name",style: StyleUtils.description,)),
                SearchField(
                    validator: ValidationUtils.validateLengthRange("Name", 4,maxLength: 15),
                    label: "Name",
                    controller: textFieldControllers.nameController),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Date of birth",style: StyleUtils.description,)),
                SearchField(
                  onTap: (){
                    textFieldControllers.dateOfBirthDialogue(context);
                  },
                    readOnly: true,
                    validator:ValidationUtils.validateRequired("Date of birth"),
                    label: "DD//MM/YYYY",
                    controller: textFieldControllers.dateOfBirthController),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Major",style: StyleUtils.description,)),
                SearchField(
                    validator: ValidationUtils.validateLengthRange("Major", 5,maxLength: 22),
                    label: "Your field i.e. Software engineering",
                    controller: textFieldControllers.majorController),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Role",style: StyleUtils.description,)),
                SearchField(
                    validator: ValidationUtils.validateLengthRange("Role", 4,maxLength: 15),
                    label: "Your i.e. Personal",
                    controller: textFieldControllers.roleController),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Bio",style: StyleUtils.description,)),
                SearchField(
                    validator: ValidationUtils.validateLengthRange("Bio", 20,maxLength: 180),
                    multiLine: true,
                    keyboard: TextInputType.multiline,
                    label: "Your i.e. Hello I am.....",
                    controller: textFieldControllers.bioController),
                const SizedBox(height: 10,),
            Obx(() => textFieldControllers.loading.value?
            const Center(child:  CircularProgressIndicator(
              color: ColorUtils.blueShade,
              backgroundColor: ColorUtils.redShade,
            ))
                : Padding(
                  padding: const EdgeInsets.fromLTRB(14,0,14,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
               Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        textFieldControllers.onClick();
                      },
                      title: "Save",
                      imagePath: ImagePathUtils.save,
                      color: ColorUtils.blueShade),
                ),
                    ],
                  ),
                ),
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

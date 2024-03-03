import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Controllers/Auth/signup_controller.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:event_management/ViewModel/Widgets/textField/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/Functions/chack_data_utils.dart';
import '../../ViewModel/Functions/validate_form.dart';
import '../../ViewModel/Widgets/textField/search_field.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
final signupController=Get.find<SignupController>();

    return  Scaffold(

      backgroundColor: ColorUtils.blueShade,
      body:  SingleChildScrollView(
        child: Form(
          key: GlobalKeys.formKeyValidation,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: context.height*0.2,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text("Welcome To",style: StyleUtils.whiteHeading24,),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text("\t\tSnap Gather",style: StyleUtils.brownHeading24,),
                  ),
                ),
                SizedBox(height: context.height*0.15,),
                Container(
                  decoration:const  BoxDecoration(
                    color: ColorUtils.whiteColor,
                    borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                           Text("Sign Up",style: StyleUtils.titleHeading,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Email",style: StyleUtils.description,)),
                            SearchField(
                                validator:ValidationUtils.validateEmail,
                                keyboard: TextInputType.emailAddress,
                                label: "email123@gmail.com",
                                controller: signupController.emailController),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Password",style: StyleUtils.description,)),
                       Obx(() => PasswordField(
                         label: "At least 6 characters",
                         controller: signupController.unVerifyPasswordController,
                         show: !signupController.hide.value,
                         onTap: (){
                           signupController.hidePassword();
                         },
                         validator: ValidationUtils.validateLengthRange("Password", 6,maxLength: 20),
                       ), ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Verify Password",style: StyleUtils.description,)),
                          Obx(() =>PasswordField(
                            show: !signupController.hideVerify.value,
                            label: "Re-enter the same password",
                            controller: signupController.verifyPasswordController,
                            onTap: (){
                              signupController.hideVerifyPassword();
                            },
                            validator: ValidationUtils.validateLengthRange("Password", 6,maxLength: 20),
                          )),
                            SizedBox(height: context.height*0.02,),
                            Row(
                              children: [
                                Expanded(child:
                                PrimaryButton(
                                  onPressed: (){
                                    signupController.signupClick(GlobalKeys.formKeyValidation);
                                  },
                                  color: ColorUtils.blueShade,
                                  imagePath: ImagePathUtils.join, title: 'Join',
                                ))
                              ],
                            ),
                            SizedBox(height: context.height*0.05,),
                            RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "Already have an account? ",style: StyleUtils.description),
                                TextSpan(text: "Login",style: StyleUtils.blueHeading,
                                recognizer: TapGestureRecognizer()..onTap=(){
                                  NavigationUtils.pushToLogin();
                                }
                                ),
                              ]
                            )),
                            SizedBox(height: context.height*0.02,)
                          ],
                        ),
                      )
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

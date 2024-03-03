import 'package:event_management/ViewModel/Controllers/Auth/login_controller.dart';
import 'package:event_management/ViewModel/Functions/chack_data_utils.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/AppStrings/app_colors.dart';
import '../../ViewModel/AppStrings/image_path.dart';
import '../../ViewModel/AppStrings/text_style.dart';
import '../../ViewModel/Functions/validate_form.dart';
import '../../ViewModel/Widgets/Button/primary.dart';
import '../../ViewModel/Widgets/textField/password_field.dart';
import '../../ViewModel/Widgets/textField/search_field.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController=Get.find<LoginController>();

    return Scaffold(
      backgroundColor: ColorUtils.blueShade,
      body: SingleChildScrollView(
        child: Form(
          key: GlobalKeys.loginFormValidationKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: context.height*0.2,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Text("Welcome Back To",style: StyleUtils.whiteHeading24,),
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
                decoration: const BoxDecoration(
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
                          Text("Log In",style: StyleUtils.titleHeading,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Email",style: StyleUtils.description,)),
                          SearchField(
                              validator:ValidationUtils.validateEmail,
                              keyboard: TextInputType.emailAddress,
                              label: "email123@gmail.com",
                              controller: loginController.emailController),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Password",style: StyleUtils.description,)),
                          Obx(() => PasswordField(
                            label: "At least 6 characters",
                            controller: loginController.verifyPasswordController,
                            show: !loginController.hide.value,
                            onTap: (){
                              loginController.hidePassword();
                            },
                            validator: ValidationUtils.validateLengthRange("Password", 6,maxLength: 20),
                          ), ),
                          SizedBox(height: context.height*0.02,),
                          Obx(() => loginController.loading.value?
                          const Align(
                            alignment: Alignment.center,
                            child:  Center(child:  CircularProgressIndicator(
                              color: ColorUtils.blueShade,
                              backgroundColor: ColorUtils.redShade,
                            )),
                          ) : Row(
                            children: [
                           Expanded(child: PrimaryButton(
                             onPressed: (){
                               loginController.loginClick(GlobalKeys.loginFormValidationKey);
                             },
                             color: ColorUtils.blueShade,
                             imagePath: ImagePathUtils.join, title: 'Log In',
                           ))

                            ],
                          ), ),
                          SizedBox(height: context.height*0.05,),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "Don't have an account? ",style: StyleUtils.description),
                                TextSpan(text: "Sign Up",style: StyleUtils.blueHeading,
                                    recognizer: TapGestureRecognizer()..onTap=(){
                                  NavigationUtils.pushToSignup();
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

import 'dart:math';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Functions/email_utils.dart';

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();
  final TextEditingController unVerifyPasswordController =
      TextEditingController();

  RxBool hide = true.obs;
  RxBool hideVerify = true.obs;

  //Toggle password
  void hidePassword() {
    hide.toggle();
  }

  //toggle reenter password
  void hideVerifyPassword() {
    hideVerify.toggle();
  }

  //signup Click
  void signupClick(GlobalKey<FormState> formKeyValidation) async {
    if (formKeyValidation.currentState!.validate() &&
        verifyPasswordController.text.toString() ==
            unVerifyPasswordController.text.toString()) {
      Random random = Random();
      int randomNumber = random.nextInt(2300) + 1000;

      MailUtils.sendEmail(
          emailController.text.toString(), "Your Pin code is $randomNumber");
      NavigationUtils.pushToPinCodeScreen(
          randomNumber,
          emailController.text.toString(),
          unVerifyPasswordController.text.toString());
    } else {
      if (unVerifyPasswordController.text.toString() !=
          verifyPasswordController.text.toString()) {
        MessageUtils.showErrorSnackBar("Error", "passwords must be same");
      } else {
        MessageUtils.showErrorSnackBar("Error", "Please Fill all fields");
      }
    }
  }
}

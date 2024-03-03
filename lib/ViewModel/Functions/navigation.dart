import 'package:event_management/ViewModel/Controllers/Auth/basic_information_controller.dart';
import 'package:event_management/ViewModel/Controllers/Auth/login_controller.dart';
import 'package:event_management/ViewModel/Controllers/Auth/signup_controller.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:event_management/view/Auth/basic_information.dart';
import 'package:event_management/view/Auth/login.dart';
import 'package:event_management/view/BottomNav/Profile/editProfile/edit_profile.dart';
import 'package:event_management/view/BottomNav/addEvent/add_event_main.dart';
import 'package:event_management/view/BottomNav/eventDetail/event_detail_main.dart';
import 'package:event_management/view/BottomNav/nav_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view/Auth/signup.dart';
import '../../view/Auth/verify.dart';

class NavigationUtils {
  //Same as pop
  static void pagePop() {
    Get.back();
  }

  //Same as push
  static void pushToEditProfile(UserModel data) {
    Get.to(
        () => EditProfileMain(
              data: data,
            ),
        transition: Transition.zoom,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600));
  }

//push to add event
  static void pushToAddEvent() {
    Get.to(() => const AddEventMain(),
        transition: Transition.upToDown,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600));
  }



  //remove all page from stack and go to signup
  static void popUntilSignup() {
    debugPrint("press1");
    Get.offAll(() => const SignupScreen(),
        transition: Transition.downToUp,
        curve: Curves.easeInOut, binding: BindingsBuilder(() {
      // Use Get.put to ensure that the same instance of LoginController is used
      Get.put(SignupController());
    }), duration: const Duration(milliseconds: 600));
  }

  //same as push Replacement
  static void pushToPinCodeScreen(
      int randomNumber, String email, String password) {
    Get.offAll(
        () => VerifyScreen(
              initialRandomNumber: randomNumber,
              email: email,
              password: password,
            ),
        transition: Transition.leftToRight,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600));
  }

  //remove all page from stack and go to Navigation
  static void popUntilNav() {
    Get.offAll(() => const NavMain(),
        transition: Transition.downToUp,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600));
  }

  //remove all page from stack and go to BasicInformation
  static void popUntilBasicInformation() {
    Get.offAll(() => const BasicInformation(), binding: BindingsBuilder(() {
      // Use Get.put to ensure that the same instance of LoginController is used
      Get.put(BasicInformationController());
    }),
        transition: Transition.downToUp,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600));
  }

  //push To signup
  static void pushToSignup() {
    Get.to(() => const SignupScreen(),
        transition: Transition.rightToLeftWithFade,
        curve: Curves.easeInOut, binding: BindingsBuilder(() {
      // Use Get.put to ensure that the same instance of LoginController is used
      Get.put(SignupController());
    }), duration: const Duration(milliseconds: 600));
  }

  //pushToLogin
  static void pushToLogin() {
    Get.to(() => const LoginScreen(),
        transition: Transition.rightToLeftWithFade,
        curve: Curves.easeInOut, binding: BindingsBuilder(() {
      // Use Get.put to ensure that the same instance of LoginController is used
      Get.put(LoginController());
    }), duration: const Duration(milliseconds: 600));
  }
}

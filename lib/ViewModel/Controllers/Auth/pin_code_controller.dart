import 'dart:async';
import 'dart:math';
import 'package:event_management/ViewModel/Controllers/Auth/signup_controller.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Functions/email_utils.dart';

class VerifyController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  late int currentRandomNumber;
  RxBool isResendClickable = true.obs;
  RxBool loading = false.obs;
  String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
  //set loading
  void setLoading(bool value) {
    loading.value = value;
  }

  VerifyController({required int initialRandomNumber}) {
    currentRandomNumber = initialRandomNumber;
  }

  void generateNewRandomNumber() {
    currentRandomNumber = Random().nextInt(9000) + 1000;
  }

  void startResendTimer() {
    Timer(const Duration(seconds: 50), () {
      isResendClickable.value = true;
    });
  }

  //inserting data
  Future insertUserData(String email, String password, String? uid) async {
    await DatabaseUtils.requestServer(() async {
      await FirebaseFirestore.instance.collection("userData").doc(uid).set({
        "dateTime": DateTime.now(),
        "uid": uid,
        "email": email,
        "password": password,
        "imageUrl": ""
      });
    });
  }

  //user Signup
  Future<void> firebaseSignup(String email, String password) async {
    try {
      setLoading(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await insertUserData(
          email, password, FirebaseAuth.instance.currentUser?.uid);
      MessageUtils.showSuccessSnackBar("Success", "Sign in Successfully");
      NavigationUtils.popUntilBasicInformation();
    } catch (error) {
      DatabaseUtils.handleFirebaseError(error);
      Get.delete<SignupController>();
      Get.delete<VerifyController>();
      NavigationUtils.popUntilSignup();
    } finally {
      setLoading(false);
    }
  }

  void handlePinCodeChange(String email, String password) async {
    if (textEditingController.text == currentRandomNumber.toString()) {
      await firebaseSignup(email, password);
    } else if (textEditingController.text.length == 4) {
      MessageUtils.showErrorSnackBar("Incorrect", "Incorrect pin code");
    }
  }

  void handleVerifyButton(String email, String password) async {
    if (textEditingController.text == currentRandomNumber.toString()) {
      await firebaseSignup(email, password);
    } else {
      MessageUtils.showErrorSnackBar("Incorrect", "Incorrect pin code");
    }
  }

  void resendCode(String email) {
    if (isResendClickable.value) {
      generateNewRandomNumber();
      MailUtils.sendEmail(email, "Your Pin code is $currentRandomNumber");
      // Mail.sendEmail(widget.email, "Your Pin code is $currentRandomNumber");
      isResendClickable.value = false;
      startResendTimer();
    }
  }
}

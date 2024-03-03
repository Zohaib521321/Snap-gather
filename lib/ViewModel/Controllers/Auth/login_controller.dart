import 'package:event_management/ViewModel/Functions/chack_data_utils.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Functions/snack_bar.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();

  final loginFormValidationKey = GlobalKey<FormState>();

  RxBool hide = true.obs;
  RxBool loading = false.obs;
  void hidePassword() {
    hide.toggle();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      setLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: verifyPasswordController.text.toString());

      NavigationUtils.popUntilNav();
      //data exist
    } catch (e) {
      DatabaseUtils.handleFirebaseError(e);
    } finally {
      setLoading(false);
    }
  }

  void loginClick(GlobalKey<FormState> loginFormValidationKey) async {
    if (loginFormValidationKey.currentState!.validate()) {
      await loginWithEmailAndPassword();
      // Dispose of the controller after login
      Get.delete<LoginController>();
    } else {
      MessageUtils.showErrorSnackBar("Error", "Please Fill all fields");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    verifyPasswordController.dispose();
    loading.close();
    super.dispose();
  }
}

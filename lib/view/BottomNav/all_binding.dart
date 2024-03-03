import 'package:event_management/ViewModel/Controllers/Auth/basic_information_controller.dart';
import 'package:event_management/ViewModel/Controllers/Auth/login_controller.dart';
import 'package:event_management/ViewModel/Controllers/Auth/signup_controller.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/profile/edit_profile_controllers.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/profile/image_picker_controller.dart';
import 'package:event_management/ViewModel/Controllers/theme_controller.dart';
import 'package:get/get.dart';
class AllBindingController implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ImagePickerController());
    Get.put(EditProfileController());
    Get.put(SignupController());
    Get.put(BasicInformationController());
    Get.put(LoginController());
  }
}
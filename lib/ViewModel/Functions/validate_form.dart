import 'package:get/get.dart';

class ValidationUtils {
  // Validate if the length is greater than a specified minimum range (e.g., 20)
  static String? Function(String?) validateLengthRange(String name, int minLength, {int? maxLength}) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "$name is required";
      }
      if (!GetUtils.isLengthGreaterThan(value!, minLength)) {
        return "Length must be greater than $minLength";
      }
      if (maxLength != null && GetUtils.isLengthGreaterThan(value, maxLength)) {
        return "Length must be less than $maxLength";
      }
      // Return null when the value is valid
      return null;
    };
  }

  // Validate if the value is a valid email address
  static String? validateEmail(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Email is required";
    }
    if (!GetUtils.isEmail(value!)) {
      return "Email must be valid";
    }
    // Return null when the value is valid
    return null;
  }

  // Validate if the field is required
  static String? Function(String?) validateRequired(String name) {
    return (String? value) {
      if (GetUtils.isNullOrBlank(value)!) {
        return "$name is required";
      }
      // Return null when the value is valid
      return null;
    };
  }
}

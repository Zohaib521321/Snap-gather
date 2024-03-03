import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
class PasswordField extends StatelessWidget {
  final String label;
  final bool show;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  const PasswordField({super.key,
    required this.label,
    required this.controller,
    this.show=true,
    this.validator,  this.onTap});
  @override
  Widget build(BuildContext context) {
    print("show is ${!show}");
    return TextFormField(
      obscureText: !show,
      autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as the user types
      cursorColor: ColorUtils.pinkShade,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        suffixIcon: InkWell(
            onTap: onTap,
            child: Image.asset(show?ImagePathUtils.unSeen:ImagePathUtils.seen)),
        fillColor: ColorUtils.lightGrey,
        hintStyle: StyleUtils.lightW400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:const EdgeInsets.only(
          top: 9,
          left: 15,
          right: 10,
          bottom: 8,
        ),
      ),

    );
  }
}

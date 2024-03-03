import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
class SearchField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final bool multiLine;
  final bool readOnly;
  final VoidCallback? onTap;
  const SearchField({super.key,
    required this.label,
    required this.controller,
    this.multiLine=false,
    this.validator, this.keyboard,
     this.readOnly=false, this.onTap});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:multiLine?null:1,
      autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as the user types
      onTap: onTap,
      onTapOutside: (value){
        FocusScope.of(context).unfocus();
      },
      cursorColor: ColorUtils.pinkShade,
      controller: controller,
      readOnly: readOnly,
      keyboardType:keyboard??TextInputType.text,
      validator: validator,

      decoration: InputDecoration(
        hintText: label,
        filled: true,
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

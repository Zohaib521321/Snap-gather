import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String imagePath;
  final Color color;
  const PrimaryButton({super.key, required this.onPressed, required this.title, required this.imagePath, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: color
      ),
        onPressed: onPressed,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(imagePath),
        ),

        label:
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 8,top: 7,bottom: 7),
          child: Text(title,style: StyleUtils.whiteW400,),
        )
    );
  }
}

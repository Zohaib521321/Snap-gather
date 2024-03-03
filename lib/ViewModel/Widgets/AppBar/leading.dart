import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Leading extends StatelessWidget {
  const Leading({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
  onTap: (){
  NavigationUtils.pagePop();
},
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.89),
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
            )),
        padding: const EdgeInsets.only(
          top: 7,
          left: 9,
          right: 8.55,
          bottom: 6,
        ),

        child:
            Image.asset(ImagePathUtils.back),

      ),
    );
  }
}

import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
class RowIcon extends StatelessWidget {
  final String image;
  final String title;
  const RowIcon({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image),
       const SizedBox(width: 9,),
        Text(title,style: StyleUtils.description,),

      ],
    );
  }
}

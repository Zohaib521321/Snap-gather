import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:flutter/material.dart';
class TwoWidgetColumn extends StatelessWidget {
  final String text1;
  final String text2;
  const TwoWidgetColumn({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(text1,style: StyleUtils.titleHeading,)),
        Align(
            alignment: Alignment.topLeft,
            child: Text(text2,style: StyleUtils.description,)),
        SizedBox(height: 10,)
      ],
    );
  }
}

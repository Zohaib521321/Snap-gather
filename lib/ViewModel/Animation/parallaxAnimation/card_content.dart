import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Widgets/rowColumn/row_icon.dart';
import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final String price;
  final Widget changeButton;
  final String location;
  const CardContent({
    super.key,
    required this.name,
    required this.date,
    required this.price,
    required this.changeButton,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: StyleUtils.descriptionForTitle),
          const SizedBox(height: 8),
          RowIcon(
            image: ImagePathUtils.clock,
            title: date,
          ),
          const SizedBox(height: 8),
          RowIcon(image: ImagePathUtils.location, title: location),
          const Spacer(),
          Row(
            children: <Widget>[
              changeButton,
              Spacer(),
              Text(
                '$price',
                style: const TextStyle(
                  color: ColorUtils.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}

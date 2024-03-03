import 'package:event_management/ViewModel/extension/media_query.dart';
import 'package:flutter/material.dart';
import '../../../../ViewModel/Animation/parallaxAnimation/parallax_animation.dart';
import '../../../../ViewModel/AppStrings/app_colors.dart';
import '../../../../ViewModel/AppStrings/image_path.dart';
import '../../../../ViewModel/Functions/date_time.dart';
import '../../../../ViewModel/Functions/show_dialogue.dart';
import '../../../../ViewModel/Widgets/Button/primary.dart';
class CelebrateMain extends StatelessWidget {
  const CelebrateMain({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return   Column(
      children: [
        SizedBox(height: context.height*0.04,),
        Expanded(
          child: ParallaxAnimation(
            collection: "category",
              condition: "Celebrate",
              btnWidget:  PrimaryButton(onPressed: (){
                DialogueUtils.exitDialogue("Join",const Text("Do you want to Join event?"),
                    "Join", ImagePathUtils.join,
                    ColorUtils.blueShade, () {
                    });
              }, title: "Join",
                  imagePath: ImagePathUtils.join,
                  color: ColorUtils.blueShade)
          ),
        ),
      ],
    );
  }
}

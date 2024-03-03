import '../../../../ViewModel/Animation/parallaxAnimation/parallax_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ViewModel/AppStrings/app_colors.dart';
import '../../../../ViewModel/AppStrings/image_path.dart';
import '../../../../ViewModel/Functions/show_dialogue.dart';
import '../../../../ViewModel/Widgets/Button/primary.dart';

class ConnectionsMain extends StatelessWidget {
  const ConnectionsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.04,
        ),
        Expanded(
          child: ParallaxAnimation(
              collection: "category",
              condition: "Connections",
              btnWidget: PrimaryButton(
                  onPressed: () {
                    DialogueUtils.exitDialogue(
                        "Join",
                        const Text("Do you want to Join event?"),
                        "Join",
                        ImagePathUtils.join,
                        ColorUtils.blueShade, () {
                      print("Joined");
                    });
                  },
                  title: "Join",
                  imagePath: ImagePathUtils.join,
                  color: ColorUtils.blueShade)),
        ),
      ],
    );
  }
}

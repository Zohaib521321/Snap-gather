import 'package:event_management/ViewModel/extension/media_query.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../ViewModel/Animation/parallaxAnimation/parallax_animation.dart';
import '../../../ViewModel/AppStrings/app_colors.dart';
import '../../../ViewModel/AppStrings/image_path.dart';
import '../../../ViewModel/Functions/date_time.dart';
import '../../../ViewModel/Functions/show_dialogue.dart';
import '../../../ViewModel/Widgets/Button/primary.dart';

class ProfileEvent extends StatelessWidget {
  const ProfileEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.02,
          ),
          Container(
            height: context.height * 0.55,
            child: ParallaxAnimation(
              height: context.height * 0.27,
              organiser: true,
              collection: "uid",
              condition: FirebaseAuth.instance.currentUser!.uid,
              btnWidget: PrimaryButton(
                  onPressed: () {
                    DialogueUtils.exitDialogue(
                        "Delete",
                        const Text("Do you want to delete event?"),
                        "Delete",
                        ImagePathUtils.delete,
                        ColorUtils.redShade, () {
                      print("leaved");
                    });
                  },
                  title: "Delete",
                  imagePath: ImagePathUtils.delete,
                  color: ColorUtils.redShade),
            ),
          ),
        ],
      ),
    );
  }
}

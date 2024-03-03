import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/extension/media_query.dart';
import 'package:flutter/material.dart';
import '../../../ViewModel/Animation/joinParallax/join_parallax.dart';

class PastJoined extends StatelessWidget {
  const PastJoined({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.04,
        ),
        Expanded(
          child: JoinParallaxAnimation(
              organiser: false, condition: CollectionUtils.pastStream),
        ),
      ],
    );
  }
}

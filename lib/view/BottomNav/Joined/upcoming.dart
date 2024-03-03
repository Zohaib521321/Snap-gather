import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/Animation/joinParallax/join_parallax.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/extension/media_query.dart';
import 'package:flutter/material.dart';

class UpcomingJoined extends StatelessWidget {
  const UpcomingJoined({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.04,
        ),
        Expanded(
          child: JoinParallaxAnimation(
            condition: CollectionUtils.upcomingStream,
          ),
        ),
      ],
    );
  }
}

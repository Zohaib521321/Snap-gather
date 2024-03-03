import 'package:event_management/ViewModel/Controllers/bottomNav/join_tab_controller.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/join_appbar.dart';
import 'package:event_management/view/BottomNav/Joined/past.dart';
import 'package:event_management/view/BottomNav/Joined/upcoming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class JoinMain extends StatelessWidget {
  const JoinMain({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      const UpcomingJoined(),
      const PastJoined(),
    ];

    return  Scaffold(
      appBar:const JoinCustomAppBar(),
      body: GetBuilder<JoinTabChangeIndexController>(
        init: JoinTabChangeIndexController(),
        builder: (controller){
          return  TabBarView(
              physics:const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: tabViews);
        },)
    );
  }
}

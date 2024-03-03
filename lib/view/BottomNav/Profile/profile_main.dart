import 'package:event_management/ViewModel/Controllers/bottomNav/profile_tab_controller.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/profile_appbar.dart';
import 'package:event_management/view/BottomNav/Profile/about.dart';
import 'package:event_management/view/BottomNav/Profile/events.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      const ProfileEvent(),
      const ProfileAbout(),
    ];

    return  Scaffold(
        appBar:const ProfileCustomAppBar(),
        body: GetBuilder<ProfileTabChangeIndexController>(
          init: ProfileTabChangeIndexController(),
          builder: (controller){
            return  TabBarView(
                physics:const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: tabViews);
          },)
    );  }

}

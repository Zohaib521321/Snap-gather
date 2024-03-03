import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/tab_controller.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Celebrate/celebrate_main.dart';
import 'Community/community_main.dart';
import 'Connections/connections_main.dart';
import 'knowledge/knowledge_main.dart';

class HomePageMain extends StatelessWidget {
  const HomePageMain({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      const ConnectionsMain(),
      const KnowledgeMain(),
      const CelebrateMain(),
      const CommunityMain(),
    ];
    return Scaffold(
        appBar: const CustomAppBar(),
        body: GetBuilder<TabChangeIndexController>(
          init: TabChangeIndexController(),
          builder: (controller) {
            return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: tabViews);
          },
        ));
  }
}

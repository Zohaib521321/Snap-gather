// Import the necessary material and gesture detector libraries
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppStrings/app_colors.dart';
import '../../Controllers/bottomNav/tab_controller.dart';
class TabBarHome extends StatelessWidget {
final List<String> title;
const TabBarHome({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.07,
      decoration: BoxDecoration(
        color: ColorUtils.greyShade,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
      GetBuilder<TabChangeIndexController>(
          init: TabChangeIndexController(),
          builder: (tabController){

        return TabBar(
          controller: tabController.tabController,
          tabs: title.map((String tabTitle) {
            return Tab(
              text: tabTitle,
            );
          }).toList(),
          indicatorWeight: 7,
          indicatorPadding:const EdgeInsets.only(top: 3,bottom: 3,left: -6,right: -6),
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:  Colors.brown
          ),
          labelColor: Colors.black, // Set the selected text color here
          onTap: (index) {
            tabController.onChange(index);
          },

          isScrollable: true,
        );
      }),
    );
  }
}
// Obx(
//       () => SizedBox(
//     height: context.height * 0.60,
//     child: tabViews[tabController.selectedIndex.value],
//   ),
// )
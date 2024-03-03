// Import the necessary material and gesture detector libraries
import 'package:event_management/ViewModel/Controllers/bottomNav/join_tab_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppStrings/app_colors.dart';
class JoinTabBar extends StatelessWidget {
  const JoinTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width/1.5,
      height: context.height * 0.07,
      decoration: BoxDecoration(
        color: ColorUtils.greyShade,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GetBuilder<JoinTabChangeIndexController>(
            init: JoinTabChangeIndexController(),
        builder: (tabController){
              return       TabBar(
                controller: tabController.tabController,
                tabs:const [
                  Padding(
                    padding: EdgeInsets.only(left: 12,right: 12,top: 8,),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Upcoming", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12,right: 12,top: 8,),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.clock_fill, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Past", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
                isScrollable: true,
                labelColor: Colors.black, // Text color when selected
                unselectedLabelColor: Colors.brown, // Text color when not selected
                indicatorPadding: const EdgeInsets.only(left: 8,right: 8),
                indicatorWeight: 12,
                indicator: BoxDecoration(
                  color: Colors.brown, // Background color when selected
                  borderRadius: BorderRadius.circular(10),
                ),

                onTap: (index) {
                  tabController.onChange(index);
                },
              );
            },),
    );
  }
}
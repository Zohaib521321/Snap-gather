import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/nav_controller.dart';
import 'package:event_management/ViewModel/Widgets/NavBar/nav_widget.dart';
import 'package:event_management/view/BottomNav/Homepage/homepage_main.dart';
import 'package:event_management/view/BottomNav/Joined/join_main.dart';
import 'package:event_management/view/BottomNav/Profile/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavMain extends StatelessWidget {
  const NavMain({super.key});

  @override
  Widget build(BuildContext context) {
    List<CodingWithZohaibBottomBarItem> items = [
      CodingWithZohaibBottomBarItem(
          icon: Image.asset(ImagePathUtils.homeBlack),
          title: const Text("Home"),
          activeIcon: Image.asset(ImagePathUtils.homePink)),
      CodingWithZohaibBottomBarItem(
          icon: Image.asset(ImagePathUtils.calendarBlack),
          title: const Text("Joined"),
          activeIcon: Image.asset(ImagePathUtils.calenderPink)),
      CodingWithZohaibBottomBarItem(
          icon: Image.asset(ImagePathUtils.userBlack),
          title: const Text("Profile"),
          activeIcon: Image.asset(ImagePathUtils.userPink)),
    ];
    List<Widget> pages = [
      const HomePageMain(),
      const JoinMain(),
      const ProfileMain(),
    ];
    final bottomNavController = Get.put(NavController());
    return Scaffold(
      body: Obx(() =>
          IndexedStack(
            index: bottomNavController.selectedIndex.value,  //Your Current Index
            children: pages,                       //List Of Pages
          ),
      ),
      bottomNavigationBar:Obx(()=> ClipRRect(
       borderRadius:const BorderRadius.only(
         topLeft: Radius.circular(12.0),
         topRight: Radius.circular(12.0),
       ),
        child: CodingWithZohaibBottomBar(
          backgroundColor: Colors.white,
          items: items,
          selectedItemColor: ColorUtils.pinkShade,
          margin:const EdgeInsets.all(12),
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: (index) {
            bottomNavController.changeIndex(index);
          },

        ),
      ),)
    );
  }
}

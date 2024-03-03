import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Widgets/tabBar/join_tab_bar.dart';
import 'package:flutter/material.dart';
import '../../AppStrings/app_colors.dart';
import '../../Functions/navigation.dart';
class JoinCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const JoinCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text("Snap Gather",style: StyleUtils.heading,),
        elevation: 10,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))
        ),
        backgroundColor: ColorUtils.whiteColor,
        actions: [
          IconButton(onPressed: (){
            NavigationUtils.pushToAddEvent();
          }, icon:Image.asset(  ImagePathUtils.addIcon)),

        ],
        bottom: const PreferredSize(
          preferredSize:Size.fromHeight(kToolbarHeight),
          child: SingleChildScrollView(
            child: Column(
              children: [
                JoinTabBar(),
                SizedBox(height: 12,)
              ],
            ),
          ),
        )
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+100);
}

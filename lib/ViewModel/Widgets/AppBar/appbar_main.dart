import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:flutter/material.dart';
import '../tabBar/tab_bar_home.dart';
import '../textField/search_field.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> title = ["Connections", "Knowledge", "Celebrate", "Community"];
    final controller=TextEditingController();
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
        }, icon:Image.asset(ImagePathUtils.addIcon)),


      ],
      bottom:  PreferredSize(
        preferredSize:const Size.fromHeight(kToolbarHeight),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
              children: [
                  SearchField(label: "Search"
                    ,controller: controller,),
                 const SizedBox(height: 10,),
                TabBarHome(title: title,),
                const SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      )
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+130);
}

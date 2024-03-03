import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:event_management/ViewModel/Widgets/dataFetch/my_stream_builder.dart';
import 'package:event_management/ViewModel/Widgets/tabBar/profile_tab_bar.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Functions/show_dialogue.dart';
class ProfileCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ProfileCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uid=FirebaseAuth.instance.currentUser!.uid;
    return AppBar(
        title: Text("Snap Gather",style: StyleUtils.heading,),
        elevation: 10,
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            NavigationUtils.pushToAddEvent();

          }, icon:Image.asset(ImagePathUtils.addIcon)),


        ],
        bottom:   PreferredSize(
          preferredSize:const Size.fromHeight(kToolbarHeight),
          child: SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.only(left: 12,right: 12),
              child: Column(

                children: [
                  CustomStreamBuilder(stream:CollectionUtils.userDataCollection
                      .where("uid",isEqualTo: uid).snapshots(),
                      builder: (QuerySnapshot snapshot){
                    if(snapshot.docs.isEmpty){
                      return const Center(
                        child: CircularProgressIndicator(color: ColorUtils.blueShade,
                        backgroundColor: ColorUtils.redShade,
                        ),
                      );
                    }
                    UserModel user = UserModel.fromJson(snapshot.docs.first.data()
                    as Map<String, dynamic>);

                        return Column(
                          children: [
                            Row(
                              children: [
                                 CircleAvatar(
                                  radius: 35,
                                  backgroundColor: ColorUtils.greyShade,
                                  backgroundImage:user.imageUrl.isNotEmpty?NetworkImage(user.imageUrl):null,
                                ),
                                const SizedBox(width: 20,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Text(user.name,style: StyleUtils.titleHeading,),
                                      Text(user.email,style: StyleUtils.description,)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryButton(onPressed: (){
                                  NavigationUtils.pushToEditProfile(user);
                                }, title: "Edit Profile",
                                    imagePath: ImagePathUtils.edit,
                                    color: ColorUtils.blueShade),
                                PrimaryButton(onPressed: (){
                                  DialogueUtils.exitDialogue("Log Out",
                                      const Text("Do you want to Log Out your account?"),
                                      "Log out", ImagePathUtils.leave,
                                      ColorUtils.redShade, () async{
                                        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                                        await firebaseAuth.signOut();
                                        await firebaseAuth.currentUser?.reload();
                                        NavigationUtils.popUntilSignup();
                                      });
                                }, title: "Log Out",
                                    imagePath: ImagePathUtils.leave,
                                    color: ColorUtils.redShade),
                              ],
                            ),
                          ],
                        );



                      }),

                  const SizedBox(height: 10,),
                  const ProfileTabBar(),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
          ),
        )
    );
  }
  @override
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight+200);
}

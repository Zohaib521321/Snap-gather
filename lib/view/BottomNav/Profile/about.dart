import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Functions/date_time.dart';
import 'package:event_management/ViewModel/Widgets/dataFetch/my_stream_builder.dart';
import 'package:event_management/ViewModel/Widgets/rowColumn/coloumn.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../ViewModel/AppStrings/app_colors.dart';
class ProfileAbout extends StatelessWidget {
  const ProfileAbout({super.key});
  @override
  Widget build(BuildContext context) {
    final uid=FirebaseAuth.instance.currentUser!.uid;
    return SingleChildScrollView(
      child: Padding(
        padding:  const EdgeInsets.all(12.0),
        child:CustomStreamBuilder(
          stream: CollectionUtils.userDataCollection.where("uid",isEqualTo: uid).snapshots(),
          builder: (QuerySnapshot snapshot){
            if(snapshot.docs.isEmpty){
              return  const Center(
                child: CircularProgressIndicator(color: ColorUtils.blueShade,
                  backgroundColor: ColorUtils.redShade,
                ),
              );
            }
            final user=UserModel.fromJson(snapshot.docs.first.data()
            as Map<String,dynamic>);
            return   Column(
              children: [
                TwoWidgetColumn(text1: "Birthday", text2:user.dobString),
                TwoWidgetColumn(text1: "Major", text2:user.major),
                TwoWidgetColumn(text1: "Bio", text2:user.bio),
                TwoWidgetColumn(text1: "Join Date",
                    text2:DateTimeStamp.formatDateToDDMMYYYY(user.joinDate)),
              ],
            );
        },)



      ),
    );
  }
}

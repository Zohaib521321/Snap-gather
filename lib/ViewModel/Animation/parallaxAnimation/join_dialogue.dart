// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_management/ViewModel/Animation/parallaxAnimation/payment.dart';
// import 'package:event_management/ViewModel/Functions/navigation.dart';
// import 'package:event_management/model/eventModel/add_event.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../AppStrings/app_colors.dart';
// import '../../AppStrings/image_path.dart';
// import '../../Functions/show_dialogue.dart';
// class JoinDialogue{
//   static void joinFun(EventModel eventModel,BuildContext context){
//     final controller=Get.put(CurrencyConvert());
//
//     DialogueUtils.exitDialogue(
//         "Join",
//        const  Text("Do you want to Join event?") ,
//         "Join",
//         ImagePathUtils
//             .join,
//         ColorUtils
//             .blueShade,
//             ()async {
//           NavigationUtils.pagePop();
//          await controller.stripePayment("700", () {
//             FirebaseFirestore.instance.collection("userJoin")
//                 .doc(eventModel.id)
//                 .set({
//               "model": eventModel,
//               "uid": eventModel.id,
//             });
//           },
//            context);
//         });
//   }
// }
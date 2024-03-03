import 'package:event_management/ViewModel/Animation/parallaxAnimation/payment.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:event_management/ViewModel/Functions/date_time.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/leading.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:event_management/ViewModel/Widgets/rowColumn/row_icon.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:event_management/model/eventModel/add_event.dart';
import 'package:event_management/view/BottomNav/eventDetail/edit_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ViewModel/AppStrings/database_collection.dart';
import '../../../ViewModel/Functions/chack_data_utils.dart';
import '../../../ViewModel/Functions/navigation.dart';
import '../../../ViewModel/Functions/show_dialogue.dart';
import '../../../ViewModel/Functions/snack_bar.dart';

class EventDetailMain extends StatelessWidget {
  final bool organizer;
  final EventModel userModel;
  const EventDetailMain(
      {super.key, this.organizer = false, required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Leading(),
            ),
            stretch: true,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Image.network(
                userModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            userModel.title,
                            style: StyleUtils.titleHeading,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      RowIcon(
                          image: ImagePathUtils.clock,
                          title: DateTimeStamp.formatDateToDDMMYYYY(
                              userModel.dateTime)),
                      RowIcon(
                          image: ImagePathUtils.location,
                          title: userModel.location),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "About",
                            style: StyleUtils.titleHeading,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userModel.detail,
                        style: StyleUtils.description,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Organiser",
                            style: StyleUtils.titleHeading,
                          )),
                      FutureBuilder(
                          future: DatabaseUtils.getNameRole(),
                          builder: (builder, snapshot) {
                            if (snapshot.hasError) {
                              return Container();
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            List<String> roleName = snapshot.data!;
                            return ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: ColorUtils.pinkShade,
                              ),
                              title: Text(
                                roleName[0],
                                style: StyleUtils.description,
                              ),
                              subtitle: Text(
                                roleName[1],
                                style: StyleUtils.black12,
                              ),
                            );
                          }),
                      organizer
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                          onPressed: () {
                                            Get.to(
                                                () => EditEvent(
                                                    eventModel: userModel),
                                                transition: Transition.downToUp,
                                                curve: Curves.easeInOut,
                                                duration: const Duration(
                                                    milliseconds: 600));
                                          },
                                          title: "Edit",
                                          imagePath: ImagePathUtils.edit,
                                          color: ColorUtils.blueShade),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: PrimaryButton(
                                          onPressed: () {
                                            DialogueUtils.exitDialogue(
                                                "Delete",
                                                const Text(
                                                    "Do you want to delete event?"),
                                                "Delete",
                                                ImagePathUtils.delete,
                                                ColorUtils.redShade, () async {
                                              await CollectionUtils.addEvent
                                                  .doc(userModel.id)
                                                  .delete()
                                                  .then((value) {
                                                MessageUtils.showErrorSnackBar(
                                                    "Deleted",
                                                    "Event Deleted Successfully");
                                                NavigationUtils.pagePop();
                                                NavigationUtils.pagePop();
                                              });
                                            });
                                          },
                                          title: "Delete",
                                          imagePath: ImagePathUtils.delete,
                                          color: ColorUtils.redShade),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                    "Total Joined Users are ${userModel.joinedUser.length}")
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PrimaryButton(
                                        onPressed: () async {
                                          final controller =
                                              Get.put(CurrencyConvert());
                                          await CheckDataUtils.checkJoinedUser(
                                                  userModel.id)
                                              .then((value) {
                                            print("Event ID: ${userModel.id}");
                                            print(
                                                "Is User Joined: ${userModel.joinedUser.contains(FirebaseAuth.instance.currentUser!.uid)}");
                                            if (value != null ||
                                                userModel.joinedUser.contains(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid)) {
                                              MessageUtils.showErrorSnackBar(
                                                  "Sorry",
                                                  "You already Joined this event");
                                            } else {
                                              controller.joinFun(
                                                  userModel.price,
                                                  userModel.toMap(),
                                                  context);
                                            }
                                          });
                                        },
                                        title:
                                            "Join \t\t\t\t\t${userModel.price} \$",
                                        imagePath: ImagePathUtils.join,
                                        color: ColorUtils.blueShade),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ]))
        ],
      ),
    );
  }
}

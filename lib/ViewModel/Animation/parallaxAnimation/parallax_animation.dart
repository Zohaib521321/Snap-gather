import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/Animation/parallaxAnimation/parallax_controller.dart';
import 'package:event_management/ViewModel/Animation/parallaxAnimation/payment.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/Functions/chack_data_utils.dart';
import 'package:event_management/ViewModel/Functions/date_time.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:event_management/model/eventModel/add_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view/BottomNav/eventDetail/event_detail_main.dart';
import '../../AppStrings/database_collection.dart';
import '../../AppStrings/image_path.dart';
import '../../Functions/show_dialogue.dart';
import '../../Widgets/Button/primary.dart';
import '../../Widgets/dataFetch/my_stream_builder.dart';
import 'card_content.dart';

final bucketGlobal = PageStorageBucket();

class ParallaxAnimation extends StatelessWidget {
  final bool organiser;
  final Widget btnWidget;
  final double? height;
  final String collection;
  final String condition;
  const ParallaxAnimation(
      {super.key,
      required this.btnWidget,
      this.height,
      required this.collection,
      required this.condition,
      this.organiser = false});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.8);
    return PageStorage(
        bucket: bucketGlobal,
        child: CustomStreamBuilder(
            stream: CollectionUtils.addEvent
                .where(collection, isEqualTo: condition)
                .where("visibility",
                    whereIn: organiser ? ["Private", "Public"] : ["Public"])
                .where("dateTime",
                    isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
                .snapshots(),
            builder: (QuerySnapshot snapshot) {
              if (snapshot.docs.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<EventModel> event = snapshot.docs.map((value) {
                final data = value.data() as Map<String, dynamic>;
                return EventModel.fromMap(data);
              }).toList();
              return PageView.builder(
                  clipBehavior: Clip.none,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: event.length,
                  itemBuilder: (itemBuilder, index) {
                    final data = event[index];
                    String dateTime =
                        DateTimeStamp.formatDateToDDMMYYYY(data.dateTime);
                    return GetBuilder<ParallaxController>(
                        init: ParallaxController(),
                        builder: (offsetController) {
                          return AnimatedBuilder(
                              animation: pageController,
                              builder: (context, child) {
                                offsetController.updatePageOffset(
                                    offsetController, pageController, index);
                                double gauss = offsetController.calculateGauss(
                                    offsetController.pageOffset.value);
                                return Transform.translate(
                                  offset: Offset(
                                      -32 *
                                          gauss *
                                          offsetController
                                              .pageOffset.value.sign,
                                      0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => EventDetailMain(
                                          organizer: organiser,
                                          userModel: data,
                                        ),
                                        transition: Transition.fade,
                                        duration:
                                            const Duration(milliseconds: 900),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                          color: ColorUtils.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorUtils.blackColor
                                                  .withOpacity(0.1),
                                              offset: const Offset(8, 20),
                                              blurRadius: 24,
                                            )
                                          ]),
                                      clipBehavior: Clip.none,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(32)),
                                            child: Image.network(
                                              data.imageUrl,
                                              alignment: Alignment(
                                                  offsetController
                                                      .pageOffset.value,
                                                  0), //not working in fit image if no then worked fine
                                              height: height ??
                                                  context.height * 0.30,
                                              fit: BoxFit.none,
                                              width: double.infinity,
                                            ),
                                          ),
                                          // Rest of the content
                                          const SizedBox(height: 8),
                                          Expanded(
                                            child: CardContent(
                                                location: data.location,
                                                name: data.title,
                                                date: dateTime.toString(),
                                                price: data.price == "0.00"
                                                    ? "Free"
                                                    : "${data.price}  \$",
                                                changeButton: organiser
                                                    ? PrimaryButton(
                                                        onPressed: () {
                                                          DialogueUtils
                                                              .exitDialogue(
                                                                  "Delete",
                                                                  const Text(
                                                                      "Do you want to delete event?"),
                                                                  "Delete",
                                                                  ImagePathUtils
                                                                      .delete,
                                                                  ColorUtils
                                                                      .redShade,
                                                                  () {
                                                            CollectionUtils
                                                                .addEvent
                                                                .doc(data.id)
                                                                .delete()
                                                                .then((value) {
                                                              MessageUtils
                                                                  .showErrorSnackBar(
                                                                      "Deleted",
                                                                      "Event Deleted Successfully");
                                                              NavigationUtils
                                                                  .pagePop();
                                                            });
                                                          });
                                                        },
                                                        title: "Delete",
                                                        imagePath:
                                                            ImagePathUtils
                                                                .delete,
                                                        color:
                                                            ColorUtils.redShade)
                                                    : GetBuilder<
                                                            CurrencyConvert>(
                                                        init: CurrencyConvert(),
                                                        builder: (controller) {
                                                          return PrimaryButton(
                                                              onPressed:
                                                                  () async {
                                                                await CheckDataUtils
                                                                        .checkJoinedUser(data
                                                                            .id)
                                                                    .then(
                                                                        (value) {
                                                                  print(
                                                                      "Event ID: ${data.id}");
                                                                  print(
                                                                      "Is User Joined: ${data.joinedUser.contains(FirebaseAuth.instance.currentUser!.uid)}");
                                                                  if (value !=
                                                                          null ||
                                                                      data.joinedUser.contains(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)) {
                                                                    MessageUtils.showErrorSnackBar(
                                                                        "Sorry",
                                                                        "You already Joined this event");
                                                                  } else {
                                                                    controller.joinFun(
                                                                        data.price,
                                                                        data.toMap(),
                                                                        context);
                                                                  }
                                                                });
                                                              },
                                                              title: "Join",
                                                              imagePath:
                                                                  ImagePathUtils
                                                                      .join,
                                                              color: ColorUtils
                                                                  .blueShade);
                                                        })),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                  });
            }));
  }
}

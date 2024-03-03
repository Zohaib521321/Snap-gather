import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/Animation/parallaxAnimation/parallax_controller.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Functions/date_time.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/show_dialogue.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../AppStrings/image_path.dart';
import '../../Widgets/Button/primary.dart';
import '../../Widgets/dataFetch/my_stream_builder.dart';
import '../parallaxAnimation/card_content.dart';

final bucketGlobal = PageStorageBucket();

class JoinParallaxAnimation extends StatelessWidget {
  final bool organiser;
  final Stream<QuerySnapshot<Object?>> condition;
  const JoinParallaxAnimation(
      {super.key, this.organiser = true, required this.condition});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.8);
    return PageStorage(
        bucket: bucketGlobal,
        child: CustomStreamBuilder(
            stream: condition,
            builder: (QuerySnapshot snapshot) {
              if (snapshot.docs.isEmpty) {
                return Lottie.asset(ImagePathUtils.empty);
              }
              return PageView.builder(
                  clipBehavior: Clip.none,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.docs.length,
                  itemBuilder: (itemBuilder, index) {
                    final data = snapshot.docs[index]["model"];
                    String dateTime =
                        DateTimeStamp.formatDateToDDMMYYYY(data["dateTime"]);
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
                                      MessageUtils.showErrorSnackBar("Sorry",
                                          "You can not see detail of event from here");
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
                                              data["thumbnail"],
                                              alignment: Alignment(
                                                  offsetController
                                                      .pageOffset.value,
                                                  0), //not working in fit image if no then worked fine
                                              height: context.height * 0.30,
                                              fit: BoxFit.none,
                                              width: double.infinity,
                                            ),
                                          ),
                                          // Rest of the content
                                          const SizedBox(height: 8),
                                          Expanded(
                                            child: CardContent(
                                              location: data["location"],
                                              name: data["title"],
                                              date: dateTime.toString(),
                                              price: data["price"] == "0.00"
                                                  ? "Free"
                                                  : "${data["price"]}  \$",
                                              changeButton: PrimaryButton(
                                                  onPressed: () async {
                                                    organiser
                                                        ? DialogueUtils
                                                            .exitDialogue(
                                                                "Leave",
                                                                const Text(
                                                                    "Do you want to leave event"),
                                                                "Leave",
                                                                ImagePathUtils
                                                                    .leave,
                                                                ColorUtils
                                                                    .redShade,
                                                                () {
                                                            CollectionUtils
                                                                .joinData
                                                                .doc(data["id"])
                                                                .delete()
                                                                .then((value) {
                                                              MessageUtils
                                                                  .showSuccessSnackBar(
                                                                      "Leaved",
                                                                      "Event Leaved Successfully");
                                                              NavigationUtils
                                                                  .pagePop();
                                                            });
                                                          })
                                                        : DialogueUtils
                                                            .exitDialogue(
                                                                "Delete",
                                                                const Text(
                                                                    "Do you want to delete event"),
                                                                "Delete",
                                                                ImagePathUtils
                                                                    .delete,
                                                                ColorUtils
                                                                    .redShade,
                                                                () {
                                                            CollectionUtils
                                                                .joinData
                                                                .doc(data["id"])
                                                                .delete()
                                                                .then((value) {
                                                              MessageUtils
                                                                  .showSuccessSnackBar(
                                                                      "Deleted",
                                                                      "Event deleted Successfully");
                                                            });
                                                          });
                                                  },
                                                  title: organiser
                                                      ? "Leave"
                                                      : "delete",
                                                  imagePath: organiser
                                                      ? ImagePathUtils.leave
                                                      : ImagePathUtils.delete,
                                                  color: ColorUtils.redShade),
                                            ),
                                          )
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

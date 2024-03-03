import 'dart:io';
import 'package:event_management/ViewModel/Animation/parallaxAnimation/payment.dart';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Functions/compress_image.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/show_dialogue.dart';
import 'package:event_management/ViewModel/Widgets/Button/primary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../Functions/snack_bar.dart';

class AddEventController extends GetxController {
  //controllers
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController eventTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController visibilityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
//key
  final addEventFormKey = GlobalKey<FormState>();
  //for event type
  RxList<String> eventTypeTitle =
      ["Connections", "Knowledge", "Celebrate", "Community"].obs;
  RxString selectedEventType = "".obs;
//for visible
  RxList<String> visibilityTitle = ["Public", "Private"].obs;
  RxString selectedVisibility = "".obs;
//images
  File? pickedImage; //picked
  XFile? compressedImage; //compress
  RxString pickGalleryImage = "".obs;
  DateTime? pickedDate;
  //loading bool
  RxBool loading = false.obs;
  void setLoading(bool newValue) {
    loading.value = newValue;
  }

  //pick image
  void pickImage() async {
    try {
      final pickImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickImage != null) {
        pickGalleryImage.value = pickImage.path;
        update();
        final compressedImage =
            await ImageUtils.compressImage(File(pickGalleryImage.value));
        if (compressedImage != null) {
          this.compressedImage = compressedImage;
          MessageUtils.showSuccessSnackBar(
              "Success", "Image Picked Successfully");
        }
      } else {
        MessageUtils.showErrorSnackBar("Error", "ImageNot picked");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //dateTime Pick
  void dateTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2122),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                    primary:
                        ColorUtils.redShade), // Text color// Button text color
              ),
              child: child!);
        });

    if (pickedDate != null) {
      TimeOfDay? pickedTime;
      if (context.mounted) {
        // Display time picker
        pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                          primary: ColorUtils.redShade)),
                  child: child!);
            });
      }

      if (pickedTime != null) {
        // Combine date and time
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (kDebugMode) {
          print(selectedDateTime);
        } // Combined date and time

        String formattedDateTime =
            DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);
        debugPrint(formattedDateTime); // Formatted date and time

        // Set output date and time to TextField value.
        dateTimeController.text = formattedDateTime;
      } else {
        debugPrint("Time is not selected");
      }
    } else {
      debugPrint("Date is not selected");
    }
  }

//select event Type
  void eventType() {
    selectedEventType.value = eventTypeTitle[0];
    //open
    DialogueUtils.confirmationDialogue(
        "Select event Type",
        Column(
          children: [
            for (String type in eventTypeTitle)
              Obx(
                () => RadioListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    selectedTileColor: ColorUtils.redShade,
                    activeColor: ColorUtils.redShade,
                    value: type,
                    groupValue: selectedEventType.value,
                    title: Text(
                      type,
                      style: StyleUtils.description,
                    ),
                    onChanged: (change) {
                      selectedEventType.value = change!;
                    }),
              ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                    onPressed: () {
                      NavigationUtils.pagePop();
                    },
                    title: "Cancel",
                    imagePath: ImagePathUtils.cancel,
                    color: ColorUtils.redShade),
                PrimaryButton(
                    onPressed: () {
                      eventTypeController.text = selectedEventType.value;
                      NavigationUtils.pagePop(); // Close the dialog
                    },
                    title: "Confirm",
                    imagePath: ImagePathUtils.save,
                    color: ColorUtils.blueShade),
              ],
            )
          ],
        ));
  }

  //choose Visibility
  void visibility() {
//assign default value
    selectedVisibility.value = visibilityTitle[0];
    //dialogue
    DialogueUtils.confirmationDialogue(
        "Choose visibility",
        Column(
          children: [
            for (String visible in visibilityTitle)
              Obx(() => RadioListTile(
                  activeColor: ColorUtils.redShade,
                  value: visible,
                  groupValue: selectedVisibility.value,
                  title: Text(
                    visible,
                    style: StyleUtils.description,
                  ),
                  onChanged: (change) {
                    selectedVisibility.value = change!;
                  })),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                    onPressed: () {
                      NavigationUtils.pagePop();
                    },
                    title: "Cancel",
                    imagePath: ImagePathUtils.cancel,
                    color: ColorUtils.redShade),
                PrimaryButton(
                    onPressed: () {
                      visibilityController.text = selectedVisibility.value;
                      NavigationUtils.pagePop();
                    },
                    title: "Confirm",
                    imagePath: ImagePathUtils.save,
                    color: ColorUtils.blueShade),
              ],
            )
          ],
        ));
  }

  //add data
  Future<void> addData() async {
    try {
      setLoading(true);
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String convertedPrice = await CurrencyConvert()
          .convert(int.parse(priceController.text.toString()));

      convertedPrice = double.parse(convertedPrice).toStringAsFixed(1);

      // Parse the string to a DateTime object
      DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime dateTime = dateFormat.parse(dateTimeController.text.toString());
      String imageUrl = await DatabaseUtils.uploadToDatabase(
          File(compressedImage!.path),
          ref: "event/$id");
      await DatabaseUtils.requestServer(() async {
        await CollectionUtils.addEvent.doc(id).set({
          "id": id,
          "uid": uid,
          "currentDate": DateTime.now(),
          "joinedUser": [],
          "price": convertedPrice,
          "visibility": visibilityController.text.toString(),
          "detail": descriptionController.text.toString(),
          "title": eventNameController.text.toString(),
          "location": locationController.text.toString(),
          "category": eventTypeController.text.toString(),
          "dateTimeStr": dateTimeController.text.toString(),
          "dateTime": dateTime,
          "thumbnail": imageUrl,
        });
      });
      NavigationUtils.pagePop();
    } finally {
      setLoading(false);
    }
  }

  //on adding event
  void onSave() async {
    if (addEventFormKey.currentState!.validate() &&
        pickGalleryImage.isNotEmpty) {
      await addData();
      MessageUtils.showSuccessSnackBar("Success", "Event added successfully");
    } else {
      if (pickGalleryImage.isEmpty) {
        MessageUtils.showErrorSnackBar("Error", "Please pick image first");
      } else {
        MessageUtils.showErrorSnackBar("Error", "Please fill all field first");
      }
    }
  }

  //update data
  void updateData(String id) async {
    try {
      setLoading(true);
      await DatabaseUtils.requestServer(() async {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
        DateTime dateTime =
            dateFormat.parse(dateTimeController.text.toString());
        String convertedPrice = await CurrencyConvert()
            .convert(int.parse(priceController.text.toString()));

        convertedPrice = double.parse(convertedPrice).toStringAsFixed(1);
        await CollectionUtils.addEvent.doc(id).update({
          "visibility": visibilityController.text.toString(),
          "detail": descriptionController.text.toString(),
          "title": eventNameController.text.toString(),
          "location": locationController.text.toString(),
          "category": eventTypeController.text.toString(),
          "dateTimeStr": dateTimeController.text.toString(),
          "price": convertedPrice,
          "dateTime": dateTime,
        }).then((value) {
          NavigationUtils.pagePop();
          NavigationUtils.pagePop();
          MessageUtils.showSuccessSnackBar("Success", "Updated Successfully");
        });
      });
    } finally {
      setLoading(false);
    }
  }

//disposing
  @override
  void onClose() {
    debugPrint("Closing Controller");
    // Dispose to prevent memory leaks
    eventNameController.dispose();
    dateTimeController.dispose();
    locationController.dispose();
    eventTypeController.dispose();
    descriptionController.dispose();
    visibilityController.dispose();
    eventTypeTitle.close();
    selectedEventType.close();
    visibilityTitle.close();
    selectedVisibility.close();
    super.onClose();
  }
}

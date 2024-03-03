import 'dart:io';
import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:event_management/ViewModel/AppStrings/image_path.dart';
import 'package:event_management/ViewModel/AppStrings/text_style.dart';
import 'package:event_management/ViewModel/Controllers/bottomNav/profile/add_event_controller.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/validate_form.dart';
import 'package:event_management/ViewModel/Widgets/AppBar/leading.dart';
import 'package:event_management/model/authModel/profile_model.dart';
import 'package:event_management/model/eventModel/add_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ViewModel/Widgets/Button/primary.dart';
import '../../../ViewModel/Widgets/textField/search_field.dart';

class EditEvent extends StatelessWidget {
  final EventModel eventModel;
  const EditEvent({super.key, required this.eventModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Leading(),
        title: Text(
          "Edit an event",
          style: StyleUtils.titleHeading,
        ),
        centerTitle: true,
        backgroundColor: ColorUtils.whiteColor,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AddEventController>(
              init: AddEventController(),
              builder: (addEvent) {
                addEvent.eventNameController.text = eventModel.title;
                addEvent.priceController.text = eventModel.price;
                addEvent.dateTimeController.text = eventModel.dateTimeStr;
                addEvent.locationController.text = eventModel.location;
                addEvent.eventTypeController.text = eventModel.category;
                addEvent.visibilityController.text = eventModel.visibility;
                addEvent.descriptionController.text = eventModel.detail;
                return Form(
                  key: addEvent.addEventFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Event name",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          validator: ValidationUtils.validateLengthRange(
                              "Event name", 5,
                              maxLength: 80),
                          label: "Enter an event name",
                          controller: addEvent.eventNameController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Event Price",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          validator: ValidationUtils.validateLengthRange(
                              "Event name", 2,
                              maxLength: 5),
                          label: "Enter an event Price in PKR",
                          keyboard: TextInputType.number,
                          controller: addEvent.priceController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date and time",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          label: "MM/DD/YYYY hh:mm",
                          readOnly: true,
                          validator:
                              ValidationUtils.validateRequired("Date time"),
                          onTap: () {
                            addEvent.dateTimePicker(context);
                          },
                          controller: addEvent.dateTimeController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Location",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          validator: ValidationUtils.validateLengthRange(
                              "Location", 4,
                              maxLength: 20),
                          label: "Add location",
                          controller: addEvent.locationController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Type",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          readOnly: true,
                          onTap: () {
                            addEvent.eventType();
                          },
                          label: "Choose an event type",
                          validator:
                              ValidationUtils.validateRequired("Event type"),
                          controller: addEvent.eventTypeController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Visibility",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          readOnly: true,
                          onTap: () {
                            addEvent.visibility();
                          },
                          label: "Visibility",
                          validator:
                              ValidationUtils.validateRequired("Visibility"),
                          controller: addEvent.visibilityController),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: StyleUtils.description,
                          )),
                      SearchField(
                          multiLine: true,
                          keyboard: TextInputType.multiline,
                          label: "Enter description of event",
                          validator: ValidationUtils.validateLengthRange(
                              "Description", 20),
                          controller: addEvent.descriptionController),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryButton(
                                onPressed: () {
                                  NavigationUtils.pagePop();
                                },
                                title: "Discard",
                                imagePath: ImagePathUtils.cancel,
                                color: ColorUtils.greyShade),
                            const Spacer(),
                            Obx(
                              () => addEvent.loading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorUtils.blueShade,
                                        backgroundColor: ColorUtils.pinkShade,
                                      ),
                                    )
                                  : PrimaryButton(
                                      onPressed: () {
                                        addEvent.updateData(eventModel.id);
                                      },
                                      title: "Update",
                                      imagePath: ImagePathUtils.save,
                                      color: ColorUtils.blueShade),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

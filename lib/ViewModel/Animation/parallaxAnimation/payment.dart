import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Functions/database_utils.dart';
import 'package:event_management/ViewModel/Functions/email_utils.dart';
import 'package:event_management/ViewModel/Functions/navigation.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/eventModel/add_event.dart';
import '../../AppStrings/app_colors.dart';
import '../../AppStrings/image_path.dart';
import '../../Functions/show_dialogue.dart';

class CurrencyConvert extends GetxController {
  RxBool loading = false.obs;
  void setLoading(bool value) {
    loading.value = value;
  }

  Future<String> convert(int amount) async {
    String baseUrl = 'https://open.er-api.com/v6/latest/USD';
    String apiKey = "Your Api Key";
    final Uri uri = Uri.parse('$baseUrl?apikey=$apiKey');
    final http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      // Successful response
      final data = json.decode(response.body);

      // Extract the exchange rate for PKR
      double exchangeRate = data['rates']['PKR'];

      // Calculate the converted amount
      double convertedAmount = amount / exchangeRate;

      // Format the result as a string
      String result = '$convertedAmount';

      return result;
    } else {
      return 'Error: ${response.reasonPhrase}';
    }
  }

  Future<void> stripePayment(String amount, Map<String, dynamic> eventModel,
      BuildContext context) async {
    Map<String, dynamic>? paymentIntent;
    final price = double.parse(amount) * 100;
    print(price.toInt().toString());
    try {
      Map<String, dynamic> body = {
        "amount": price.toInt().toString(),
        "currency": "USD",
      };
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            "Authorization": "Bearer Your_Secret_Key",
            "Content-type": "application/x-www-form-urlencoded"
          },
          body: body);
      paymentIntent = json.decode(response.body);
    } catch (e) {
// Handle specific exceptions or provide a general error message
      if (e is SocketException) {
        // Handle socket-related issues
        MessageUtils.showErrorSnackBar(
            "Network Error", "Check your internet connection and try again");
      } else {
        // Handle other exceptions
        MessageUtils.showErrorSnackBar("Error", "An error occurred: $e");
      }
      // Stop execution or return early
      return;
    }
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.system,
          merchantDisplayName: 'Zohaib',
        ))
        .then((value) {});
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print("Hello");
        print(eventModel);

        FirebaseFirestore.instance
            .collection("userJoin")
            .doc(eventModel["id"])
            .set({
          "model": eventModel,
          "uid": eventModel["uid"],
          "id": eventModel["id"],
          "dateTimeStr": eventModel["dateTimeStr"],
          "dateTime": eventModel["dateTime"],
        });
        CollectionUtils.addEvent.doc(eventModel["id"]).update({
          "joinedUser":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        });
        NavigationUtils.pagePop();
        List<String> data = await DatabaseUtils.getEmailName();
        MailUtils.sendEmail(
            data[1], "Congratulation ${data[0]}  Event joined successfully");
        MessageUtils.showSuccessSnackBar("Success", "Paid Successfully");
      });
    } catch (e) {
      // Handle other exceptions
      if (e is StripeException &&
          e.error.localizedMessage == 'The payment flow has been canceled') {
        // Handle the cancellation specifically
        NavigationUtils.pagePop();
        MessageUtils.showErrorSnackBar(
            "Cancel", "Payment canceled by the user");
      } else {
        // Handle other exceptions
        MessageUtils.showErrorSnackBar("Error", "$e");
      }
    }
  }

  void joinFun(
      String price, Map<String, dynamic> eventModel, BuildContext context) {
    DialogueUtils.exitDialogue("Join", const Text("Do you want to Join event?"),
        "Join", ImagePathUtils.join, ColorUtils.blueShade, () async {
      if (price == "0.00") {
        FirebaseFirestore.instance
            .collection("userJoin")
            .doc(eventModel["id"])
            .set({
          "model": eventModel,
          "uid": eventModel["uid"],
          "id": eventModel["id"],
          "dateTimeStr": eventModel["dateTimeStr"],
          "dateTime": eventModel["dateTime"]
        });
        CollectionUtils.addEvent.doc(eventModel["id"]).update({
          "joinedUser":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        });
        List<String> data = await DatabaseUtils.getEmailName();
        MailUtils.sendEmail(
            data[1], "Congratulation ${data[0]}  Event joined successfully");
        NavigationUtils.pagePop();
        MessageUtils.showSuccessSnackBar(
            "Success", "SuccessFully Joined Event");
      } else {
        MessageUtils.showSuccessSnackBar(
            "Success", "Please Wait for a moment to proceed payment");
        await stripePayment(price, eventModel, context);
      }
    });
  }
}

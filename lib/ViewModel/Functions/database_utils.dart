import 'dart:async';
import 'dart:io';
import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:event_management/ViewModel/Functions/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class DatabaseUtils {
  static void handleFirebaseError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          MessageUtils.showErrorSnackBar(
              "Error", "Email already exists. Please use a different email.");
          break;
        case 'weak-password':
          MessageUtils.showErrorSnackBar("Error",
              "Password is too weak. Please choose a stronger password.");
          break;
        case 'user-disabled':
          MessageUtils.showErrorSnackBar(
              "Error", "User account is disabled. Please contact support.");
          break;
        case 'network-request-failed':
          MessageUtils.showErrorSnackBar("Error",
              "Network request failed. Please check your internet connection.");
          break;
        default:
          MessageUtils.showErrorSnackBar(
            "Error",
            "Error creating user: ${error.toString()}",
          );
      }
    } else {
      // Handle other non-Firebase errors
      MessageUtils.showErrorSnackBar("Error", "An unknown error occurred.");
    }
  }

  static Future requestServer(FutureOr Function() computation) async {
    try {
      return await computation();
    } on SocketException catch (_) {
      MessageUtils.showErrorSnackBar(
          "Connection issue", " Please Check your connection");
    } on TimeoutException catch (_) {
      MessageUtils.showErrorSnackBar("Error", "Time out try again later");
    } on FormatException catch (_) {
      MessageUtils.showErrorSnackBar("Error", "Invalid response format");
    } catch (e) {
      MessageUtils.showErrorSnackBar("Error", e.toString());
    }
  }

  static Future<String> uploadToDatabase(File? compressedImage,
      {String? ref}) async {
    try {
      print("Uid is ${FirebaseAuth.instance.currentUser!.uid}");
      if (compressedImage != null) {
        storage.Reference reference = storage.FirebaseStorage.instance
            .ref(ref ?? "Profile/${FirebaseAuth.instance.currentUser!.uid}");

        // Wait for the upload to complete
        final uploadTask = reference.putFile(compressedImage);
        final storageSnapshot = await uploadTask.whenComplete(() => null);

        // Now get the download URL
        final downloadUrl = await storageSnapshot.ref.getDownloadURL();
        print("DownloadUrl is $downloadUrl");
        return downloadUrl;
      }
      throw Exception('No compressed image provided');
    } catch (e) {
      // Log and handle errors
      print('Error uploading to Firebase Storage: $e');
      throw e;
    }
  }

  static Future<List<String>> getNameRole() async {
    final ref = await CollectionUtils.userDataCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (ref.docs.isNotEmpty) {
      final name = ref.docs.first["name"];
      final role = ref.docs.first["role"];
      return [name, role];
    }
    return [];
  }

  static Future<List<String>> getEmailName() async {
    final ref = await CollectionUtils.userDataCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (ref.docs.isNotEmpty) {
      String name = ref.docs.first["name"];
      String email = ref.docs.first["email"];
      return [name, email];
    }
    return [];
  }
}

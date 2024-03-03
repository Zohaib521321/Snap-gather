import 'package:event_management/ViewModel/AppStrings/database_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CheckDataUtils {
  //current user profile data
  static Future checkUserData() async {
    final reference = await CollectionUtils.userDataCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final name = await CollectionUtils.userDataCollection
        .where("name", isNull: true)
        .get();
    if (reference.docs.isNotEmpty && name.docs.isNotEmpty) {
      return reference.docs.first;
    } else {
      return null;
    }
  }

  static Future checkJoinedUser(String id) async {
    final reference = await CollectionUtils.userDataCollection.where(
        "joinedUser",
        arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid]).get();
    final idRef = await CollectionUtils.userDataCollection
        .where("id", isEqualTo: id)
        .get();
    if (reference.docs.isNotEmpty && idRef.docs.isNotEmpty) {
      return reference.docs.first;
    } else {
      return null;
    }
  }
}

class GlobalKeys {
  static final GlobalKey<FormState> loginFormValidationKey =
      GlobalKey<FormState>();
  static final GlobalKey<FormState> formKeyValidation = GlobalKey<FormState>();
}

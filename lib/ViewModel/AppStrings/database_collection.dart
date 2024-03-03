import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CollectionUtils {
  static CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  static CollectionReference addEvent =
      FirebaseFirestore.instance.collection("addEvent");

  static CollectionReference joinData =
      FirebaseFirestore.instance.collection('userJoin');

  static Stream<QuerySnapshot<Object?>> upcomingStream = joinData
      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("dateTime",
          isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
      .snapshots();
  static Stream<QuerySnapshot<Object?>> pastStream = joinData
      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("dateTime", isLessThan: Timestamp.fromDate(DateTime.now()))
      .snapshots();
}

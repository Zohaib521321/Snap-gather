import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String uid;
  DateTime currentDate;
  List<String> joinedUser;
  String visibility;
  String detail;
  String title;
  String location;
  String category;
  String dateTimeStr;
  Timestamp dateTime;
String imageUrl;
String price;
  EventModel({
    required this.imageUrl,
    required this.id,
    required this.price,
    required this.uid,
    required this.currentDate,
    required this.joinedUser,
    required this.visibility,
    required this.detail,
    required this.title,
    required this.location,
    required this.category,
    required this.dateTimeStr,
    required this.dateTime,
  });

  // Factory method to create an EventModel from a Map
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      imageUrl: map["thumbnail"]??"",
      price: map["price"]??"",
      id: map['id'],
      uid: map['uid'],
      currentDate: (map['currentDate'] as Timestamp).toDate(),
      joinedUser: List<String>.from(map['joinedUser']),
      visibility: map['visibility'],
      detail: map['detail'],
      title: map['title'],
      location: map['location'],
      category: map['category'],
      dateTimeStr: map['dateTimeStr'],
      dateTime: map['dateTime']??DateTime.now(),
    );
  }

  // Method to convert EventModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      "thumbnail":imageUrl,
      'currentDate': currentDate,
      'joinedUser': joinedUser,
      'visibility': visibility,
      'detail': detail,
      'title': title,
      'location': location,
      'category': category,
      'dateTimeStr': dateTimeStr,
      'dateTime': dateTime,
      "price":price
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class LoginModel {
  final Timestamp dateTime;
  final String uid;
  final String email;
  final String password;
  LoginModel(
      {required this.uid,
      required this.password,
      required this.email,
      required this.dateTime});
  factory LoginModel.fromJson(Map<String, dynamic> data) {
    return LoginModel(
        uid: data["uid"]??"",
        password: data["password"]??"",
        email: data["email"]??"",
        dateTime: data["dateTime"]??DateTime.now(),
    );
  }
 Map<String,dynamic> toMap(){
    return{
    "uid":uid,
    "password":password,
    "email":email,
    "dateTime":dateTime
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final DateTime dateOfBirth;
  final DateTime joinDate;
  final String major;
  final String role;
  final String bio;
  final String uid;
  final String imageUrl;
  final String dobString;
  final Timestamp dateTime;
  final String email;
  final String password;

  UserModel({
    required this.name,
    required this.dateOfBirth,
    required this.joinDate,
    required this.major,
    required this.role,
    required this.bio,
    required this.uid,
    required this.imageUrl,
    required this.dobString,
    required this.dateTime,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      name: data["name"] as String? ?? "",
      dateOfBirth: (data["dateOfBirth"] as Timestamp?)?.toDate() ?? DateTime.now(),
      joinDate: (data["joinDate"] as Timestamp?)?.toDate() ?? DateTime.now(),
      major: data["major"] as String? ?? "",
      role: data["role"] as String? ?? "",
      bio: data["bio"] as String? ?? "",
      uid: data["uid"] as String? ?? "",
      imageUrl: data["imageUrl"] as String? ?? "",
      dobString: data["dobString"] as String? ?? "",
      dateTime: data["dateTime"]  ?? DateTime.now(),
      email: data["email"] as String? ?? "",
      password: data["password"] as String? ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "dateOfBirth": dateOfBirth,
      "joinDate": joinDate,
      "major": major,
      "role": role,
      "bio": bio,
      "uid": uid,
      "imageUrl": imageUrl,
      "dobString": dobString,
      "dateTime": dateTime,
      "email": email,
      "password": password,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailModel {
  String age;
  String gender;
  String id;

  UserDetailModel({required this.age, required this.gender, required this.id});

  factory UserDetailModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserDetailModel(
      id: snapshot.id,
      age: snapshot['age'],
        gender: snapshot['gender']
    );
  }
}

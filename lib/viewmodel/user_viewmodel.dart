import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_sample_project/constants/global_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel{

  Stream<QuerySnapshot>? getUsers() {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref = GlobalConstants().firestore
        .collection('users')
        .orderBy('date', descending: true)
        .snapshots();
    return ref;
  }
}
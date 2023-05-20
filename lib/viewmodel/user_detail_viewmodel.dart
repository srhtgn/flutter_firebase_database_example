import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_sample_project/constants/global_constants.dart';
import 'package:database_sample_project/widgets/stream_builder_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetailViewModel{

  Stream<QuerySnapshot>? getUserDetail() {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref = GlobalConstants().firestore
        .collection('user details')
        .where('userId', isEqualTo: GlobalConstants().auth.currentUser?.uid)
        .snapshots();
    return ref;
  }

  Stream<QuerySnapshot>? getSelectedUserDetail() {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref = GlobalConstants().firestore
        .collection('user details')
        .where('userId', isEqualTo: selectedId)
        .snapshots();
    return ref;
  }
}
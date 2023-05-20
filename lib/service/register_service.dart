import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_sample_project/main.dart';
import 'package:database_sample_project/view/home.dart';
import 'package:flutter/material.dart';
import 'package:database_sample_project/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService{
  Future signUp(BuildContext context, name, email, password, currentDate) async {
    final isValid = formKey.currentState!.validate();

    if(!isValid) return;

    try{
      await FirebaseAuth.instance //Email ve şifre ile kaydol
          .createUserWithEmailAndPassword(
              email: email, password: password)
          .then((value) {
        AllUserInformations(value, name, email, currentDate);
        Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const Home()), //Ana ekrana geç  //Switch to main screen
                      (Route<dynamic> route) => false);
      });
    } on FirebaseAuthException catch (e) {
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
void AllUserInformations(UserCredential value, String _name, String _userEmail, DateTime  _currentDate) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(value.user!.uid)
        .set({
      'email': _userEmail,
      'name': _name,
      'date': _currentDate,
      'id': value.user!.uid,
    });
  }
}
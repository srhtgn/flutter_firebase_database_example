import 'package:database_sample_project/main.dart';
import 'package:database_sample_project/view/home.dart';
import 'package:database_sample_project/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService{
  Future signIn(BuildContext context, email, password) async { //Girilen email ve şifre doğruysa ana sayfaya git yanlışsa hata mesajı göster
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword( //
          email: email,
          password: password).then((user) {
            Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              Home()), 
                      (Route<dynamic> route) => false);
      });
    }on FirebaseAuthException catch (e){
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
import 'package:flutter/material.dart';

class CustomNavigators{
  Future<dynamic> pushNavigator(BuildContext context, Widget widget) {
    return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => widget));
  }

  Future<dynamic> pushAndRemoveNavigator(BuildContext context, Widget widget) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) =>
                widget), //Ana ekrana geç  //Switch to main screen
        (Route<dynamic> route) => false);
  }
}
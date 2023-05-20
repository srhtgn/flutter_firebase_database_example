import 'package:database_sample_project/constants/redius_items.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<void> UserDetailAlertDialog(
      BuildContext context, Widget widget) async {
    showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: RadiusItems().radiusCircular15),
        actions: [widget],
      ),
    );
  }
}

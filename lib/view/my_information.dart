import 'package:database_sample_project/service/user_service.dart';
import 'package:database_sample_project/widgets/stream_builder_widgets.dart';
import 'package:flutter/material.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {


  @override
  Widget build(BuildContext context) {
    return UserDetailStream();
  }
}

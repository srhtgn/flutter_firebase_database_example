import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_sample_project/widgets/stream_builder_widgets.dart';
import 'package:database_sample_project/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: UsersStream()),
      ],
    );
  }
}
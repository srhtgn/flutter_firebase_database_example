import 'package:database_sample_project/widgets/stream_builder_widgets.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectedUserDetailStream();
  }
}

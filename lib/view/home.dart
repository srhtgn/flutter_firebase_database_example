import 'dart:ui';

import 'package:database_sample_project/constants/constant_project_texts.dart';
import 'package:database_sample_project/constants/global_constants.dart';
import 'package:database_sample_project/constants/redius_items.dart';
import 'package:database_sample_project/items/custom_alert_dialog.dart';
import 'package:database_sample_project/constants/padding_items.dart';
import 'package:database_sample_project/constants/sized_box_items.dart';
import 'package:database_sample_project/items/custom_navigators.dart';
import 'package:database_sample_project/model/user_detail_model.dart';
import 'package:database_sample_project/service/user_service.dart';
import 'package:database_sample_project/view/landing_page.dart';
import 'package:database_sample_project/view/login_page.dart';
import 'package:database_sample_project/view/my_information.dart';
import 'package:database_sample_project/view/user_list.dart';
import 'package:database_sample_project/viewmodel/user_detail_viewmodel.dart';
import 'package:database_sample_project/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum _MyTabViews { DigerKullanicilar, Bilgilerim }

extension _MyTabViewExtension on _MyTabViews {}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final currentUser = GlobalConstants().auth.currentUser!;

  late final TabController _tabController;

  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _MyTabViews.values.length,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: false,
              title: Text(ConstantProjectTexts().projectTitle),
              actions: [
                IconButton(
                    onPressed: () {
                      GlobalConstants().auth.signOut();
                      CustomNavigators().pushAndRemoveNavigator(context, LandingPage());
                    },
                    icon: Icon(Icons.exit_to_app)),
                IconButton(
                    onPressed: () {
                      CustomAlertDialog().UserDetailAlertDialog(
                        context,
                        Center(
                          child: Column(
                            children: [
                              Text(ConstantProjectTexts().addUserDetailsText,
                                  style: Theme.of(context).textTheme.headline6),
                              CustomTextFormField(
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: ConstantProjectTexts().ageText),
                                validator: (value) =>
                                    value != null && value.length < 1
                                        ? ConstantProjectTexts().ageInputFieldWarningText
                                        : null,
                              ),
                              SizedBox(height: 16),
                              CustomTextFormField(
                                controller: _genderController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText:
                                        ConstantProjectTexts().genderText),
                                validator: (value) => value != 'e' &&
                                        value != 'E' &&
                                        value != 'k' &&
                                        value != 'K'
                                    ? ConstantProjectTexts().genderInputFieldWarningText
                                    : null,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  UserService().addData(
                                    _ageController.text.trim(),
                                    _genderController.text.trim(),
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(ConstantProjectTexts().saveText),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.add))
              ],

              bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: _MyTabViews.values
                      .map((e) => Tab(text: '   ${e.name}   '))
                      .toList())),
          body: Padding(
              padding: PaddingItems.pagePaddingAll, child: _tabbarView()),
        ));
  }

  TabBarView _tabbarView() {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [const UserList(), MyInformation()]);
  }
}

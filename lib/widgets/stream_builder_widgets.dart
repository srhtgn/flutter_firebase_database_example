import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_sample_project/constants/constant_project_texts.dart';
import 'package:database_sample_project/constants/global_constants.dart';
import 'package:database_sample_project/items/custom_alert_dialog.dart';
import 'package:database_sample_project/constants/redius_items.dart';
import 'package:database_sample_project/view/user_details.dart';
import 'package:database_sample_project/viewmodel/user_detail_viewmodel.dart';
import 'package:database_sample_project/viewmodel/user_viewmodel.dart';
import 'package:database_sample_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? selectedId;
String? selectedName;
String? currentUserName;

class UsersStream extends StatefulWidget {
  const UsersStream({super.key});

  @override
  State<UsersStream> createState() => _UsersStreamState();
}

class _UsersStreamState extends State<UsersStream> {
  

  UserViewModel _userViewModel = UserViewModel();

  late List<DocumentSnapshot> listOfDocumentSnap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userViewModel.getUsers(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Center(child: Text(ConstantProjectTexts().tryAgainWarningText));
          } else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (asyncSnapshot.hasData) {
              listOfDocumentSnap = asyncSnapshot.data.docs;

              return ListView.builder(
                itemCount: listOfDocumentSnap.length,
                itemBuilder: (context, index) {

                  var _name = listOfDocumentSnap[index]['name'];
                  var _email = listOfDocumentSnap[index]['email'];
                  var _date = listOfDocumentSnap[index]['date'];
                  var _id = listOfDocumentSnap[index]['id'];

                  if(_id == GlobalConstants().auth.currentUser?.uid){
                    currentUserName = _name;
                    return Container();
                  }else return InkWell(
                    child: ListTile(
                      title: Text(_name),
                      subtitle: Text(_email),
                      trailing: Text('${GlobalConstants().dateFormat.format(_date.toDate())}'),
                  
                    ),
                    onTap: (){
                        selectedId = _id;
                      selectedName = _name;
                      
                    CustomAlertDialog().UserDetailAlertDialog(context, Center(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  child: SelectedUserDetailStream(),
                                ),
                              ));
                    },
                  )

                  ;
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        });
  }
}

class SelectedUserDetailStream extends StatelessWidget {
  SelectedUserDetailStream({super.key});


  UserDetailViewModel _userDetailViewModel = UserDetailViewModel();

  late List<DocumentSnapshot> listOfDocumentSnap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userDetailViewModel.getSelectedUserDetail(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Center(child: Text(ConstantProjectTexts().tryAgainWarningText));
          } else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (asyncSnapshot.hasData) {
              listOfDocumentSnap = asyncSnapshot.data.docs;

              return ListView.builder(
                itemCount: listOfDocumentSnap.length,
                itemBuilder: (context, index) {
                  var _age = listOfDocumentSnap[index]['age'];
                  var _gender = listOfDocumentSnap[index]['gender'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Kullanıcı Detayı', style: Theme.of(context).textTheme.headline6),
                      Text('${ConstantProjectTexts().nameText} : ${selectedName!}', style: Theme.of(context).textTheme.subtitle1),
                      Text('${ConstantProjectTexts().ageText} : ${_age}', style: Theme.of(context).textTheme.subtitle1),
                      Text('${ConstantProjectTexts().genderText} : ${_gender}', style: Theme.of(context).textTheme.subtitle1),
                    ],
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        });
  }
}

class UserDetailStream extends StatelessWidget {
  UserDetailStream({super.key});


  UserDetailViewModel _userDetailViewModel = UserDetailViewModel();

  late List<DocumentSnapshot> listOfDocumentSnap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userDetailViewModel.getUserDetail(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Center(child: Text(ConstantProjectTexts().tryAgainWarningText));
          } else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (asyncSnapshot.hasData) {
              listOfDocumentSnap = asyncSnapshot.data.docs;

              return ListView.builder(
                itemCount: listOfDocumentSnap.length,
                itemBuilder: (context, index) {
                  var _age = listOfDocumentSnap[index]['age'];
                  var _gender = listOfDocumentSnap[index]['gender'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ConstantProjectTexts().nameText} : ${selectedName!}', style: Theme.of(context).textTheme.subtitle1),
                      Text('${ConstantProjectTexts().ageText} : ${_age}', style: Theme.of(context).textTheme.subtitle1),
                      Text('${ConstantProjectTexts().genderText} : ${_gender}', style: Theme.of(context).textTheme.subtitle1),
                    ],
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        });
  }
}

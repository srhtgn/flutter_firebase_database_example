import 'package:database_sample_project/constants/constant_project_texts.dart';
import 'package:database_sample_project/constants/padding_items.dart';
import 'package:database_sample_project/constants/sized_box_items.dart';
import 'package:database_sample_project/widgets/custom_text_form_field.dart';
import 'package:database_sample_project/service/register_service.dart';
import 'package:database_sample_project/service/user_service.dart';
import 'package:database_sample_project/view/home.dart';
import 'package:database_sample_project/view/landing_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formKey = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dateFormat = DateFormat('dd.MM.yyyy');
  var currentDate = DateTime.now();

TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(ConstantProjectTexts().registerTitle),
      ),
      body: Padding(
        padding: PaddingItems.pagePaddingAll,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: ConstantProjectTexts().nameText),
                    validator: (value) => value != null && value.length < 1
                          ? ConstantProjectTexts().nameInputFieldWarningText
                          : null,
              ),
              SizedBoxItems.height16,
              CustomTextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: ConstantProjectTexts().emailText),
                    validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? ConstantProjectTexts().emailInputFieldWarningtext
                                  : null,
              ),
              SizedBoxItems.height16,
              CustomTextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: ConstantProjectTexts().passwordtext),
                      validator: (value) =>
                              value != null && value.length < 8
                                  ? ConstantProjectTexts().passwordInputFieldWarningText
                                  : null,
                      ),
              SizedBoxItems.height16,
              ElevatedButton(
                onPressed: () {
                  RegisterService().signUp(
                      context,
                      _nameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      currentDate);
                },
                child: Text(ConstantProjectTexts().signUpText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

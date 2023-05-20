import 'package:database_sample_project/constants/constant_project_texts.dart';
import 'package:database_sample_project/constants/padding_items.dart';
import 'package:database_sample_project/constants/sized_box_items.dart';
import 'package:database_sample_project/items/custom_navigators.dart';
import 'package:database_sample_project/widgets/custom_text_form_field.dart';
import 'package:database_sample_project/service/login_service.dart';
import 'package:database_sample_project/view/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstantProjectTexts().loginTitle),
      ),
      body: Padding(
        padding: PaddingItems.pagePaddingAll,
        child: Form(
            key: formKey,
            child: Column(
              children: [
                
                CustomTextFormField(
                  controller: _emailController, 
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: ConstantProjectTexts().emailText),
                validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? ConstantProjectTexts().emailInputFieldWarningtext
                                  : null,
                ),
                
                SizedBoxItems.height16,
                
                CustomTextFormField(
                  controller: _passwordController, 
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: ConstantProjectTexts().passwordtext),
                validator: (value) =>
                              value != null && value.length < 8
                                  ? ConstantProjectTexts().passwordInputFieldWarningText
                                  : null,
                ),
                
                SizedBoxItems.height16,
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(ConstantProjectTexts().memberQuery),
                    
                    TextButton(
                      onPressed: () {
                        CustomNavigators().pushNavigator(context, RegisterPage());
                      },
                      child: Text(ConstantProjectTexts().signUpText),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    LoginService().signIn(context, _emailController.text.trim(),
                        _passwordController.text.trim());
                  },
                  child: Text(ConstantProjectTexts().loginText),
                ),
              ],
            )),
      ),
    );
  }

  
}
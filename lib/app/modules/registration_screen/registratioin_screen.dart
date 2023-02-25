import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/app/const/enums.dart';
import 'package:firebase_demo_app/app/const/extensions.dart';
import 'package:firebase_demo_app/app/const/style.dart';
import 'package:firebase_demo_app/app/model/language_constant.dart';
import 'package:firebase_demo_app/app/model/language_model.dart';
import 'package:firebase_demo_app/app/services/firestore_service.dart';
import 'package:firebase_demo_app/app/widgets/custom_button_widget.dart';
import 'package:firebase_demo_app/app/widgets/custom_text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String routeName = "/registarion";
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController? emailController,
      passwordController,
      mobileController,
      usernameController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    mobileController = TextEditingController();
    usernameController = TextEditingController();
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).login),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
                underline: SizedBox(),
                icon: Icon(Icons.language),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>((e) {
                  return DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        children: [
                          Text(e.flag, style: TextStyle(fontSize: 15)),
                          SizedBox(width: 10,),
                          Text(e.name, style: TextStyle(fontSize: 15))
                        ],
                      ));
                }).toList(),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context, _locale);
                  }
                }),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFeildWidget(
                controller: usernameController!,
                textfieldstyle: TextFeildType.username,
                prefixIcon: Icon(Icons.person)),
            CustomTextFeildWidget(
                controller: emailController!,
                textfieldstyle: TextFeildType.email,
                prefixIcon: Icon(Icons.email)),
            CustomTextFeildWidget(
                controller: mobileController!,
                textfieldstyle: TextFeildType.mobile,
                prefixIcon: Icon(Icons.phone)),
            CustomTextFeildWidget(
                controller: passwordController!,
                textfieldstyle: TextFeildType.password,
                prefixIcon: Icon(Icons.password)),
            CustomButtonWidget(
              text: "Register",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  String? response = await FirestoreService.createUser(context,
                      email: emailController!.text,
                      password: passwordController!.text,
                      username: usernameController!.text,
                      mobile: mobileController!.text);
                  log("log log log $response");
                  if (response == null) {
                    Navigator.pop(context);
                  } else {
                    ErrorMessage(context, errorMessage: response);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

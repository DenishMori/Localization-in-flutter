import 'package:firebase_demo_app/app/modules/home_screen/home_screen.dart';
import 'package:firebase_demo_app/app/modules/login_screen/login_screen.dart';
import 'package:firebase_demo_app/app/modules/login_screen/widget/using_phone_auth.dart';
import 'package:firebase_demo_app/app/modules/registration_screen/registratioin_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (_) => const LoginScreen(),
  RegistrationScreen.routeName: (_) => const RegistrationScreen(),
  UsingPhoneAuth.routeName: (_) => const UsingPhoneAuth(),
  HomeScreen.routeName: (_) => const HomeScreen()
};

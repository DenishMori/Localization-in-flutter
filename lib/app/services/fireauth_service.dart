import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_app/app/const/style.dart';
import 'package:flutter/material.dart';

class FireauthService {
  static User? user = FirebaseAuth.instance.currentUser;
  static User? get getUser => user;

  static Future<String> registerUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final credantial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log("SUCCESS::: registerUser :: $credantial");

      return 'SUCCESS';
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-code") {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
      return e.code;
    } catch (e) {
      print(e);
      return 'Something went wrong';
    }
  }

  static Future<String?> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      final creadntial = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log("SUCCESS::: registerUser :: $creadntial");
      user = FirebaseAuth.instance.currentUser;
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    } catch (e) {
      print(e);
      ErrorMessage(context, errorMessage: 'Something went wrong');
      return 'Something went wrong';
    }
  }

  // static Future<void> usingPhoneAuth({required BuildContext context,required String mobile})async {

  //     final credential=
  // }
}

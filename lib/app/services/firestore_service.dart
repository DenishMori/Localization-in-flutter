// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/app/services/fireauth_service.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  static Future<String?> createUser(BuildContext context,{required String email,required String password,required String username,required String mobile}) async {

    String response = await FireauthService.registerUser(context: context, email: email, password: password);
    if (response == "SUCCESS") {
      print("current user:: ${FireauthService.getUser}");
      if (FireauthService.getUser != null) {
        FirebaseAuth.instance.currentUser?.updateDisplayName(username.trim());
        // await FirebaseFirestore.instance.collection("USERS").doc(FireauthService.getUser!.uid).set({
        //   'id': FireauthService.getUser!.uid,
        //   'username': username,
        //   'email': email,
        // });
      }
      return null;
    } else {
      return response;
    }
  }

  
}

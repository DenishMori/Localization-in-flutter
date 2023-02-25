import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/app/const/enums.dart';
import 'package:firebase_demo_app/app/getx/country_picker_getx.dart';
import 'package:firebase_demo_app/app/getx/otp_getx.dart';
import 'package:firebase_demo_app/app/widgets/custom_button_widget.dart';
import 'package:firebase_demo_app/app/widgets/custom_text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/home_screen.dart';

class UsingPhoneAuth extends StatefulWidget {
  const UsingPhoneAuth({super.key});
  static String routeName = "/phone";
  @override
  State<UsingPhoneAuth> createState() => _UsingPhoneAuthState();
}

class _UsingPhoneAuthState extends State<UsingPhoneAuth> {
  var controller = Get.put(OTPgetx());
  var countryController = Get.put(CountryPickerGetx());

  String? verificationid;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFeildWidget(
                controller: phoneController,
                textfieldstyle: TextFeildType.mobile,
                prefixIcon: const Icon(Icons.phone)),
            Obx(() {
              return Visibility(
                visible: controller.isOTPshow.value,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    controller: otpController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        prefixIcon: const Icon(Icons.numbers),
                        prefixIconColor: Colors.black54,
                        hintText: "Enter otp",
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              );
            }),
            Obx(() {
              if (controller.isOTPshow.value) {
                return CustomButtonWidget(
                    text: "Login",
                    onTap: () async {
                      final credential = PhoneAuthProvider.credential(
                          verificationId: verificationid ?? "",
                          smsCode: otpController.text);
                      try {
                        FirebaseAuth.instance.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                      } catch (e) {
                        log("auth erroe $e");
                      }
                    });
              } else {
                return CustomButtonWidget(
                    text: "Get OTP",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        controller.setVisibilty(true);
                        if (controller.isOTPshow.value) {
                          FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber:
                                "+${countryController.phoneCode}${phoneController.text}",
                            // timeout: Duration(seconds: 60),
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                            codeSent: (String verificationId,
                                int? forceResendingToken) async {
                              print("verificationId $verificationId");
                              verificationid = verificationId;
                            },
                            verificationCompleted: (PhoneAuthCredential
                                phoneAuthCredential) async {
                              await FirebaseAuth.instance
                                  .signInWithCredential(phoneAuthCredential);
                            },
                            verificationFailed: (FirebaseAuthException error) {
                              if (error.code == 'invalid-phone-number') {
                                print(
                                    'The provided phone number is not valid.');
                              }
                            },
                          );
                        }
                      }
                    });
              }
            })
          ],
        ),
      ),
    );
  }
}

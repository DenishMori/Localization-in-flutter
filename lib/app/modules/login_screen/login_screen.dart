// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/app/const/KColors.dart';
import 'package:firebase_demo_app/app/const/enums.dart';
import 'package:firebase_demo_app/app/modules/home_screen/home_screen.dart';
import 'package:firebase_demo_app/app/modules/login_screen/widget/using_phone_auth.dart';
import 'package:firebase_demo_app/app/modules/registration_screen/registratioin_screen.dart';
import 'package:firebase_demo_app/app/services/fireauth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../const/style.dart';
import '../../getx/otp_getx.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_feild_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController, passwordController;
  var controller = Get.put(OTPgetx());

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFeildWidget(
              controller: emailController!,
              textfieldstyle: TextFeildType.email,
              prefixIcon: const Icon(Icons.email)),
          CustomTextFeildWidget(
              controller: passwordController!,
              textfieldstyle: TextFeildType.password,
              prefixIcon: const Icon(Icons.password)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonWidget(
                text: "Login",
                onTap: () async {
                  String? response = await FireauthService.signIn(context,
                      email: emailController!.text,
                      password: passwordController!.text);
                  if (response == null) {
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                  } else {
                    ErrorMessage(context, errorMessage: response);
                  }
                },
              ),
              CustomButtonWidget(
                text: "Register",
                onTap: () async {
                  Navigator.pushNamed(context, RegistrationScreen.routeName);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () async {
                Navigator.pushNamed(context, UsingPhoneAuth.routeName)
                    .then((value) {
                  if (value != null) {
                    controller.setVisibilty(false);
                  }
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColor),
                      borderRadius: BorderRadius.circular(30)),
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Center(child: Text("Login with phone")))),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AuthButtonWidget(
                  onTap: () async {
                    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                    GoogleSignInAuthentication googleauth =
                        await googleUser!.authentication;
                    final credential = GoogleAuthProvider.credential(
                        accessToken: googleauth.accessToken,
                        idToken: googleauth.idToken);
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                  },
                  imageUrl: "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png",
                  text: "Google"),
              // AuthButtonWidget(
              //     onTap: () async {
              //       final LoginResult loginResult =
              //           await FacebookAuth.instance.login();

              //       final OAuthCredential facebookAuthCredential =
              //           FacebookAuthProvider.credential(
              //               loginResult.accessToken!.token);
              //       FirebaseAuth.instance
              //           .signInWithCredential(facebookAuthCredential);
              //     },
              //     imageUrl:
              //         "https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png",
              //     text: "Facebook")
            ],
          )
        ],
      ),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
      {super.key,
      required this.onTap,
      required this.imageUrl,
      required this.text});
  final void Function()? onTap;
  final String imageUrl, text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
              fit: BoxFit.cover,
              height: 30,
              width: 30,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

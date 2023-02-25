// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Text("AppLocalizations.of(context)!.personalInformation"));
  }
}

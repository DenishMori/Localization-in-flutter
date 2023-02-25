import 'package:flutter/material.dart';

ErrorMessage(BuildContext context, {required String errorMessage}) {
  return ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
    content: Text(errorMessage),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
  ));
}

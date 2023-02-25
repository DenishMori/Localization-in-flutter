import 'dart:developer';

import 'package:get/get.dart';

class OTPgetx extends GetxController{
  RxBool isOTPshow=false.obs;
  setVisibilty(bool value){
    isOTPshow.value = value;
    // log("${isOTPshow.value}");
  }
}
import 'package:get/get.dart';

class CountryPickerGetx extends GetxController{
  RxString countryCode="IN".obs;
  RxString phoneCode="91".obs;

  setCountry({required String cCode,required String pPhone}){
    countryCode.value=cCode;
    phoneCode.value=pPhone; 
  } 
}
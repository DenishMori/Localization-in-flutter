import 'package:country_picker/country_picker.dart';
import 'package:firebase_demo_app/app/const/extensions.dart';
import 'package:firebase_demo_app/app/getx/country_picker_getx.dart';
import 'package:firebase_demo_app/app/model/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/enums.dart';

class CustomTextFeildWidget extends StatefulWidget {
  const CustomTextFeildWidget(
      {super.key,
      required this.controller,
      required this.textfieldstyle,
      required this.prefixIcon});
  final TextEditingController controller;
  final Widget prefixIcon;
  final TextFeildType textfieldstyle;

  @override
  State<CustomTextFeildWidget> createState() => _CustomTextFeildWidgetState();
}

class _CustomTextFeildWidgetState extends State<CustomTextFeildWidget> {
  bool isHidePassword = false;
  var controller = Get.put(CountryPickerGetx());
  @override
  Widget build(BuildContext context) {
    switch (widget.textfieldstyle) {
      case TextFeildType.email:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: Colors.black54,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                prefixIcon: widget.prefixIcon,
                prefixIconColor: Colors.black54,
                hintText: translation(context).emailHint,
                fillColor: Colors.white,
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation(context).requiredField;
              } else if (!value.isValidEmail()) {
                return translation(context).validemail;
              }
              return null;
            },
          ),
        );
      case TextFeildType.username:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: Colors.black54,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                prefixIcon: widget.prefixIcon,
                prefixIconColor: Colors.black54,
                hintText: translation(context).nameHint,
                fillColor: Colors.white,
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation(context).emptyuser;
              }
              return null;
            },
          ),
        );
      case TextFeildType.password:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TextFormField(
              obscureText: isHidePassword ? true : false,
              controller: widget.controller,
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: isHidePassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isHidePassword = !isHidePassword;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  prefixIcon: widget.prefixIcon,
                  prefixIconColor: Colors.black54,
                  hintText: translation(context).passwordHint,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation(context).emptypassword;
                } else if (!value.isValidPassword()) {
                  return translation(context).validpassword;
                }
                return null;
              }),
        );
      case TextFeildType.mobile:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: Colors.black54,
            decoration: InputDecoration(
                
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                prefixIcon: SizedBox(
                  width: 60,
                  child: InkWell(
                      onTap: () {
                        showCountryPicker(
                            favorite: ['IN'],
                            countryListTheme: CountryListThemeData(
                              flagSize: 30,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              bottomSheetHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            context: context,
                            onSelect: (Country country) {
                              controller.setCountry(
                                  cCode: country.countryCode,
                                  pPhone: country.phoneCode);
                            });
                      },
                      child: Obx(() => Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "+ ${controller.phoneCode}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.black)
                            ],
                          ))),
                ),
                prefixIconColor: Colors.black54,
                hintText: "Enter mobile",
                fillColor: Colors.white,
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation(context).emptymobile;
              } else if (value.isNumberValid()) {
                return translation(context).validmobile;
              }
              return null;
            },
          ),
        );
      default:
        return TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
        );
    }
  }
}

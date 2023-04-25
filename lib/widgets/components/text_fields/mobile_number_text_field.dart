import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Enter Mobile Number",
          border: InputBorder.none,
          contentPadding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          prefixIcon: CountryCodePicker(
            onChanged: (countryCode) {
              widget.controller.text = countryCode.dialCode.toString();
            },
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'HK',
            // optional. Shows only country name and flag
            showCountryOnly: true,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: true,
            // optional. aligns the flag and the Text left
            alignLeft: false,
            hideMainText: true,
          ),
        ),
      ),
    );
  }
}

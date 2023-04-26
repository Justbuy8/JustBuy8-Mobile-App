import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(fontSize: 18),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter Mobile Number",
          border: InputBorder.none,
          prefixIcon: CountryCodePicker(
            initialSelection: 'HK',
            showCountryOnly: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            showOnlyCountryWhenClosed: true,
            alignLeft: false,
            hideMainText: true,
            onInit: (value) {},
            onChanged: (value) =>
                widget.controller.text = value.dialCode.toString(),
          ),
        ),
      ),
    );
  }
}

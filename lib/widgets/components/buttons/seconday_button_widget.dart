// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    Key? key,
    required this.caption,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  final String caption;
  final VoidCallback onPressed;
  final double? width, height;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 45,
      margin: const EdgeInsets.all(0.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.appGreyColor,
          foregroundColor: AppColors.appWhiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          caption,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

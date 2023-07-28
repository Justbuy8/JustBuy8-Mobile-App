import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class ColorWidget extends StatelessWidget {
  final String colorCode;
  final bool isSelected;
  final VoidCallback onPressed;

  const ColorWidget(
      {Key? key,
      required this.colorCode,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: CircleAvatar(
          backgroundColor: Color(
              int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000),
          radius: 15,
          child: isSelected
              ? Icon(
                  Ionicons.checkmark,
                  color: AppColors.appWhiteColor,
                )
              : null,
        ),
      ),
    );
  }
}

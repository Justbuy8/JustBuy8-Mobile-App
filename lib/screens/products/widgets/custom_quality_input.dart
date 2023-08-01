import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomQuantityInput extends StatelessWidget {
  final int value;
  final Function(double, String) onChanged;
  const CustomQuantityInput(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (value > 1) {
              onChanged(value - 1, "-");
            }
          },
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.appBlackColor),
            ),
            child: Icon(
              Icons.remove,
              color: AppColors.appBlackColor,
            ),
          ),
        ),
        10.width,
        Container(
          height: 30.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColors.appGreyColor.withOpacity(0.5),
          ),
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: AppFonts.robotoMonoBold,
            ),
          ),
        ),
        10.width,
        InkWell(
          onTap: () {
            onChanged(value + 1, "+");
          },
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.appBlackColor),
            ),
            child: Icon(
              Icons.add,
              color: AppColors.appBlackColor,
            ),
          ),
        ),
      ],
    );
  }
}

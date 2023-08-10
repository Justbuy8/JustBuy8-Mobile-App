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
            height: 25.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border:
                  Border.all(color: AppColors.appBlackColor.withOpacity(0.7)),
            ),
            child: Icon(
              Icons.remove,
              color: AppColors.appBlackColor.withOpacity(0.7),
            ),
          ),
        ),
        10.width,
        Container(
          height: 25.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColors.appGreyColor.withOpacity(0.5),
          ),
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: AppFonts.robotoMonoMedium,
            ),
          ),
        ),
        10.width,
        InkWell(
          onTap: () {
            onChanged(value + 1, "+");
          },
          child: Container(
            height: 25.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border:
                  Border.all(color: AppColors.appBlackColor.withOpacity(0.7)),
            ),
            child: Icon(
              Icons.add,
              color: AppColors.appBlackColor.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}

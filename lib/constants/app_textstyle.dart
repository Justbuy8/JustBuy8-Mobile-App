import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyle {
  static var heading = TextStyle(
    fontSize: 20,
    fontFamily: AppFonts.openSansBold,
  );
  static var onboardingTitleTextStyle = TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );
  static var tabsTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );

  static var topCategoriesStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );

  static var cartTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.appBlackColor,
    fontFamily: AppFonts.robotoBold,
  );

  static var html = Style(
    fontSize: FontSize(16.sp),
    fontFamily: AppFonts.openSansRegular,
  );

  static var htmlEllipsed = Style(
    fontSize: FontSize(16.sp),
    fontFamily: AppFonts.openSansRegular,
    maxLines: 2,
    textOverflow: TextOverflow.ellipsis,
  );
}

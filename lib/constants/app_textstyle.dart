import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyle {
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
}

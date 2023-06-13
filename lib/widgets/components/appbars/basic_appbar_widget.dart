import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class BasicAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;

  const BasicAppbarWidget(
      {Key? key,
      required this.title,
      this.backgroundColor,
      this.iconColor,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor ?? AppColors.appWhiteColor,
        foregroundColor: AppColors.appBlackColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontFamily: AppFonts.robotoMonoBold,
              color: titleColor),
        ),
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: iconColor),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

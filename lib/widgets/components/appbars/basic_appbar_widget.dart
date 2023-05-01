import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class BasicAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppbarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.appWhiteColor,
        foregroundColor: AppColors.appBlackColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontFamily: AppFonts.robotoMonoBold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

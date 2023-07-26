import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:nb_utils/nb_utils.dart';

class ReadMoreButton extends StatelessWidget {
  final String description;
  const ReadMoreButton({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // display modal bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: context.height() * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.descriptionText,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppFonts.robotoMonoBold,
                      ),
                    ),
                    Html(
                      data: """$description""",
                      style: {
                        "body": AppTextStyle.html,
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          "Read More",
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: AppFonts.openSansRegular,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

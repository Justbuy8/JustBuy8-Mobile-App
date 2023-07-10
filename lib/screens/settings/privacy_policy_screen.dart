import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'Privacy Policy'),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryTextWidget(
                text: 'Heading 1',
                fontSize: 20.sp,
                fontFamily: AppFonts.robotoBold,
              ),
              SizedBox(
                height: 10.h,
              ),
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 10.h,
              ),
              PrimaryTextWidget(
                text: 'Heading 1',
                fontSize: 20.sp,
                fontFamily: AppFonts.robotoBold,
              ),
              SizedBox(
                height: 10.h,
              ),
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextWidget(
                text: 'Heading 1',
                fontSize: 20.sp,
                fontFamily: AppFonts.robotoBold,
              ),
              SizedBox(
                height: 10.h,
              ),
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 10.h,
              ),
              PrimaryTextWidget(
                text: 'Heading 1',
                fontSize: 20.sp,
                fontFamily: AppFonts.robotoBold,
              ),
              SizedBox(
                height: 10.h,
              ),
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

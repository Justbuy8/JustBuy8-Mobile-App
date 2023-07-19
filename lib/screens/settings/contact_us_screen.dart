// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbarWidget(title: AppText.contactUsText),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  ImageAssets.contactUsImage,
                  height: 180.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextWidget(
                  text: AppText.contactUsText,
                  fontSize: 28,
                  fontFamily: AppFonts.openSansBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const SecondaryTextWidget(
                  text: AppText.contactUsSubtitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFieldWidget(
                  controller: _subjectController,
                  label: 'Subject',
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFieldWidget(
                  controller: _messageController,
                  maxLine: 4,
                  label: 'Message',
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButtonWidget(
                      width: context.width(),
                      height: 50.h,
                      caption: 'Send message',
                      onPressed: () {}),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Divider(),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.iconbackgroundColor),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        PrimaryTextWidget(text: '+1 222 333 444 6')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.iconbackgroundColor),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        PrimaryTextWidget(text: 'help@example.com')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

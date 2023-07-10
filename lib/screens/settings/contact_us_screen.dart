// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: 'Contact Us'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                ImageAssets.contactUsImage,
                height: 220.h,
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
                controller: _phoneNumberController,
                prefixIcon: Icons.phone_outlined,
                label: 'Phone number',
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFieldWidget(
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                label: 'Email',
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.contactUsText,
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';

import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class AccountCreatedScreen extends StatefulWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Lottie.asset(LottieAssets.accountCreated, height: 350.h),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextWidget(
                text: AppText.accountCreated,
                fontSize: 26,
                fontFamily: AppFonts.openSansBold,
              ),
              SizedBox(
                height: 20.h,
              ),
              const SecondaryTextWidget(text: AppText.accountCreatedSubtitle),
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.shopNow,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => MainTabsScreen()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 20.h, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    SecondaryTextWidget(text: AppText.skip),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Lottie.asset(LottieAssets.notification, height: 350.h),
              SizedBox(
                height: 20.h,
              ),
              PrimaryTextWidget(
                text: AppText.notification,
                fontSize: 26,
                fontFamily: AppFonts.openSansBold,
              ),
              SizedBox(
                height: 20.h,
              ),
              const SecondaryTextWidget(
                  text: AppText.notificationPermissionSubTitle),
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.allow,
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

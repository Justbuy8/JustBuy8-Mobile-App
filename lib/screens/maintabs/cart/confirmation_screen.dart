import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'Confirmation'),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Lottie.asset(LottieAssets.orderCompleted)),
            PrimaryTextWidget(
              text: 'Thankyou For Your\n Order!',
              fontSize: 32,
              fontFamily: AppFonts.robotoBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            SecondaryTextWidget(
              text: 'Your order will be delivered on time.',
              fontSize: 14,
            ),
            SizedBox(
              height: 30.h,
            ),
            PrimaryButtonWidget(caption: 'Go To Home', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

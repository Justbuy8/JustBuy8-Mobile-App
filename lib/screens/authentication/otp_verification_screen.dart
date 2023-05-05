import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/otp/otp_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const BasicAppbarWidget(
        title: AppText.verifyPhoneNumber,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const SecondaryTextWidget(
                  text: "${AppText.resetPasswordText} 033000000000"),
              SizedBox(
                height: 20.h,
              ),
              OtpWidget(
                controller: otpController,
                length: 6,
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryButtonWidget(
                  width: context.width(),
                  height: 50.h,
                  caption: AppText.verifyText,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

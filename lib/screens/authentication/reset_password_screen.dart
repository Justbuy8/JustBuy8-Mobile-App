import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/otp/otp_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(
        title: 'Reset Password',
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
                  text:
                      'Please enter the verification code we sent to your mobile 123123123'),
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
                  caption: AppText.sendInstruction,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    Key? key,
    required this.controller,
    required this.length,
    this.onCompleted,
    this.onResend,
  }) : super(key: key);

  final TextEditingController controller;
  final int length;
  final Function(String)? onCompleted;
  final VoidCallback? onResend;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pinput(
          controller: widget.controller,
          pinContentAlignment: Alignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          animationDuration: const Duration(milliseconds: 300),
          closeKeyboardWhenCompleted: true,
          keyboardType: TextInputType.number,
          length: widget.length,
          focusedPinTheme: PinTheme(
            height: context.height() / 9,
            width: context.width() / 8,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
            ),
            textStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          defaultPinTheme: PinTheme(
            height: context.height() / 9,
            width: context.width() / 8,
            textStyle: TextStyle(
              color: AppColors.appBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.appBlackColor,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            Row(
              children: [
                const SecondaryTextWidget(
                  text: "Didn't receive OTP?",
                  fontSize: 13,
                ),
                TextButton(
                  onPressed: widget.onResend ?? () {},
                  child: const PrimaryTextWidget(
                    text: "Resend OTP",
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

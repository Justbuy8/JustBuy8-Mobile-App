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
    final defaultPinTheme = PinTheme(
      height: context.width() / 8,
      width: context.width() / 8,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 231, 240, .57),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
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
            focusedPinTheme: defaultPinTheme.copyWith(
              height: context.width() / 8,
              width: context.width() / 8,
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: AppColors.primaryColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyWith(
              height: context.width() / 8,
              width: context.width() / 8,
              decoration: BoxDecoration(
                color: AppColors.dangerColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            defaultPinTheme: defaultPinTheme),
        10.height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
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
    );
  }
}

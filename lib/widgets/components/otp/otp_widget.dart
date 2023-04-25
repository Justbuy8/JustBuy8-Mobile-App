import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/text/primary_text.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    Key? key,
    required this.controller,
    required this.length,
    this.onCompleted,
    this.onResend,
  }) : super(key: key);

  final OtpFieldController controller;
  final int length;
  final Function(String)? onCompleted;
  final VoidCallback? onResend;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OTPTextField(
          length: widget.length,
          isDense: false,
          width: MediaQuery.of(context).size.width,
          textFieldAlignment: MainAxisAlignment.spaceEvenly,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          fieldStyle: FieldStyle.box,
          onCompleted: widget.onCompleted,
          controller: widget.controller,
          style: TextStyle(
            color: AppColors.appBlackColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            Row(
              children: [
                const PrimaryText(
                  text: "Didn't receive OTP?",
                  fontSize: 13,
                ),
                TextButton(
                  onPressed: widget.onResend ?? () {},
                  child: const SecondaryText(
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

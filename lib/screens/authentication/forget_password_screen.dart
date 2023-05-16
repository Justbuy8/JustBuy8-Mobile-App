import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/authentication/send_otp/send_otp_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/authentication/otp_verification_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  late SendOtpCubit sendOtpCubit;

  @override
  void initState() {
    sendOtpCubit = context.read<SendOtpCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppbarWidget(
          title: AppText.forgetPasswordAppBarTitle,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const SecondaryTextWidget(
                  text: AppText.forgetPasswordTitle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldWidget(
                  label: AppText.email,
                  prefixIcon: Ionicons.mail_outline,
                  controller: emailController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.sendInstruction,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => OtpVerificationScreen(
                              email: emailController.text.trim(),
                              tapFrom: 'forgetScreen')));
                    }),
              ],
            ),
          ),
        ));
  }
}

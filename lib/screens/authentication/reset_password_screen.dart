import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar:
            const BasicAppbarWidget(title: AppText.resetPasswordAppBarTitle),
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
                  text: AppText.enterNewPassword,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PasswordTextFieldWidget(
                  label: AppText.password,
                  prefixIcon: Ionicons.lock_closed_outline,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PasswordTextFieldWidget(
                  label: AppText.confirmPassword,
                  prefixIcon: Ionicons.lock_closed_outline,
                  controller: confirmPasswordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.changePassword,
                    onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}

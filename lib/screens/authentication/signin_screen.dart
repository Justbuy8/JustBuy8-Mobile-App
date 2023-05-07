import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180.h,
              width: context.width(),
              child: Stack(children: <Widget>[
                Image.asset(
                  ImageAssets.signInCover,
                  height: 200.h,
                  width: context.width(),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.chevron_back,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      PrimaryTextWidget(
                        text: AppText.signInText,
                        fontSize: 25.sp,
                        fontColor: Colors.white,
                        fontFamily: AppFonts.openSansBold,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: _emailController,
                    prefixIcon: Ionicons.mail_outline,
                    label: AppText.email,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  PasswordTextFieldWidget(
                    controller: _passwordController,
                    prefixIcon: Ionicons.lock_closed_outline,
                    label: AppText.password,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 18.w, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryTextWidget(
                    text: AppText.forgetPassword,
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                    fontFamily: AppFonts.openSansLight,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: PrimaryButtonWidget(
                  width: context.width(),
                  height: 50.h,
                  caption: AppText.signInText,
                  onPressed: () {}),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: Row(children: <Widget>[
                const Expanded(
                    child: Divider(
                  color: Colors.black,
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: PrimaryTextWidget(
                    text: AppText.continueWith,
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                    fontFamily: AppFonts.openSansLight,
                  ),
                ),
                const Expanded(
                    child: Divider(
                  color: Colors.black,
                )),
              ]),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Icon(
                    Ionicons.logo_facebook,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Icon(
                    Ionicons.logo_google,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Icon(
                    Ionicons.logo_apple,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryTextWidget(
                    text: AppText.dontHaveAnAccount,
                    fontSize: 14.sp,
                    fontFamily: AppFonts.openSansLight,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  PrimaryTextWidget(
                    text: AppText.signUp,
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                    fontFamily: AppFonts.robotoBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

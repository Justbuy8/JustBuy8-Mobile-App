// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/authentication/login/login_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/authentication/forget_password_screen.dart';
import 'package:justbuyeight/screens/authentication/signup_screen.dart';
import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
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
  BuildContext? dialogueContext;
  late LoginCubit loginCubit;
  final formGlobalKey = GlobalKey<FormState>();

  initCubit() {
    loginCubit = context.read<LoginCubit>();
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                dialogueContext = ctx;
                return Container(
                  color: Colors.transparent,
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: AppColors.primaryColor,
                      size: 30.0,
                    ),
                  ),
                );
              });
        } else if (state is LoginSuccessfull) {
          DismissLoadingDialog(dialogueContext);

          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const MainTabsScreen()));
        } else if (state is LoginInternetError) {
          SnackBars.Danger(context, AppText.internetError);
          DismissLoadingDialog(dialogueContext);
        } else if (state is LoginFailed) {
          SnackBars.DangerListMessage(context, state.errorMessage);
          DismissLoadingDialog(dialogueContext);
        } else if (state is LoginTimeout) {
          SnackBars.Danger(context, AppText.timeOut);
          DismissLoadingDialog(dialogueContext);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
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
                          SizedBox(
                            height: 80.h,
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
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                            controller: _emailController,
                            prefixIcon: Ionicons.mail_outline,
                            label: AppText.email,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter email address";
                              } else if (RegExp(
                                          r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(val) ==
                                  false) {
                                return "Please enter valid email address";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        PasswordTextFieldWidget(
                          controller: _passwordController,
                          prefixIcon: Ionicons.lock_closed_outline,
                          label: AppText.password,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter password";
                            } else if (val.length < 8) {
                              return "Password length should be greater than 8";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 18.w, bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => ForgetPasswordScreen()));
                        },
                        child: PrimaryTextWidget(
                          text: AppText.forgetPassword,
                          fontSize: 14.sp,
                          fontColor: Colors.black,
                          fontFamily: AppFonts.openSansLight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                  child: PrimaryButtonWidget(
                      width: context.width(),
                      height: 50.h,
                      caption: AppText.signInText,
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          var loginMap = {
                            "email": _emailController.text.trim(),
                            "password": _passwordController.text.trim()
                          };
                          await loginCubit.userLogin(loginMap);
                        }
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => const SignUpScreen()));
                        },
                        child: PrimaryTextWidget(
                          text: AppText.signUp,
                          fontSize: 14.sp,
                          fontColor: Colors.black,
                          fontFamily: AppFonts.robotoBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

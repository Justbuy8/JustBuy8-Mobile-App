// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/authentication/reset_password_cubit/reset_password_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  ResetPasswordScreen({required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  BuildContext? dialogueContext;
  late ResetPasswordCubit resetPasswordCubit;

  @override
  void initState() {
    resetPasswordCubit = context.read<ResetPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) async {
        if (state is ResetPasswordLoading) {
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
        } else if (state is ResetPasswordSuccessfuly) {
          SnackBars.Success(context, "Password updated successfully");
          Navigator.of(dialogueContext!).pop();

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => SignInScreen()));
        } else if (state is ResetPasswordFailed) {
          SnackBars.Danger(context, "Password updation failed");
          Navigator.of(dialogueContext!).pop();
        } else if (state is ResetPasswordInternetError) {
          SnackBars.Danger(context, "Internet connection failed");
          Navigator.of(dialogueContext!).pop();
        } else if (state is ResetPasswordTimeOut) {
          SnackBars.Danger(context, "Request timeout");
          Navigator.of(dialogueContext!).pop();
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar:
              const BasicAppbarWidget(title: AppText.resetPasswordAppBarTitle),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: Form(
                key: formGlobalKey,
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter password";
                        } else if (val.length < 8) {
                          return "Password length must be greater than 8";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    PasswordTextFieldWidget(
                      label: AppText.confirmPassword,
                      prefixIcon: Ionicons.lock_closed_outline,
                      controller: confirmPasswordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter password";
                        } else if (val.length < 8) {
                          return "Password length must be greater than 8";
                        } else if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          return "Confirm password must be equal";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    PrimaryButtonWidget(
                        width: context.width(),
                        height: 50.h,
                        caption: AppText.changePassword,
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            await resetPasswordCubit.resetPassword(
                                widget.email, passwordController.text.trim());
                          }
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

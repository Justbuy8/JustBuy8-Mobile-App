import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/models/authentication/user_model.dart';
import 'package:justbuyeight/screens/authentication/otp_verification_screen.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/mobile_number_text_field.dart';
import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  late ValidateEmailCubit validateEmailCubit;
  BuildContext? dialogueContext;

  initCubit() {
    validateEmailCubit = context.read<ValidateEmailCubit>();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ValidateEmailCubit, ValidateEmailState>(
      listener: (context, state) {
        if (state is ValidateEmailSuccessfuly) {
          SnackBars.Success(context, "Email verified successfully");
          UserModel userModel = UserModel();

          userModel.setFirstName = _firstNameController.text.trim();
          userModel.setLastName = _lastNameController.text.trim();
          userModel.setEmail = _emailController.text.trim();
          userModel.setPassword = _passwordController.text.trim();

          Navigator.of(dialogueContext!).pop();

          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) =>
                  OtpVerificationScreen(userModel: userModel)));
        } else if (state is ValidateEmailInternetError) {
          SnackBars.Danger(context, "Internet connection failed");
          Navigator.of(dialogueContext!).pop();
        } else if (state is ValidateEmailAlreadyExist) {
          SnackBars.Danger(context, "Email already exist");
          Navigator.of(dialogueContext!).pop();
        } else if (state is ValidateEmailFailed) {
          SnackBars.Danger(context, "Email verification failed");
          Navigator.of(dialogueContext!).pop();
        } else if (state is ValidateEmailTimeOut) {
          SnackBars.Danger(context, "Request timeout");
          Navigator.of(dialogueContext!).pop();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            return currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 180.h,
                width: context.width(),
                child: Stack(children: <Widget>[
                  Image.asset(
                    ImageAssets.signUpCover,
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
                          text: AppText.signUp,
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
              Form(
                key: formGlobalKey,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: _firstNameController,
                        prefixIcon: Ionicons.person_outline,
                        label: AppText.firstName,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter first name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFieldWidget(
                        controller: _lastNameController,
                        prefixIcon: Ionicons.person_outline,
                        label: AppText.lastName,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter last name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFieldWidget(
                        controller: _emailController,
                        prefixIcon: Ionicons.mail_outline,
                        label: AppText.email,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter email address";
                          } else if (RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(val) ==
                              false) {
                            return "Please enter valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MobileNumberTextField(
                        controller: _phoneNumberController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter phone number";
                          }
                          return null;
                        },
                      ),
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.signUp,
                    onPressed: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_ctx) {
                              dialogueContext = _ctx;
                              return Dialog(
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text('Loading...')
                                    ],
                                  ),
                                ),
                              );
                            });
                        await validateEmailCubit
                            .validateEmail(_emailController.text.trim());
                      }
                    }),
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
                      text: AppText.alreadyHaveAnAccount,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.openSansLight,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    PrimaryTextWidget(
                      text: AppText.signInText,
                      fontSize: 14.sp,
                      fontColor: Colors.black,
                      fontFamily: AppFonts.robotoBold,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

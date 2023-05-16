// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/authentication/registration/registration_cubit.dart';
import 'package:justbuyeight/blocs/authentication/send_otp/send_otp_cubit.dart';
import 'package:justbuyeight/blocs/authentication/timer_cubit/timer_cubit.dart';
import 'package:justbuyeight/blocs/authentication/verify_email_cubit/verify_email_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/authentication/user_model.dart';
import 'package:justbuyeight/screens/authentication/account_created_screen.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/otp/otp_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class OtpVerificationScreen extends StatefulWidget {
  UserModel userModel;
  OtpVerificationScreen({Key? key, required this.userModel}) : super(key: key);
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  late SendOtpCubit sendOtpCubit;
  late OtpTimerCubit otpTimerCubit;
  late RegistrationCubit registrationCubit;
  late VerifyEmailCubit verifyEmailCubit;

  BuildContext? dialogueContext;

  initCubit() {
    sendOtpCubit = context.read<SendOtpCubit>();
    otpTimerCubit = context.read<OtpTimerCubit>();
    registrationCubit = context.read<RegistrationCubit>();
    verifyEmailCubit = context.read<VerifyEmailCubit>();

    otpTimerCubit.startOtpIntervals();
  }

  @override
  void initState() {
    initCubit();
    sendOtpCubit.sendOtp(widget.userModel.getEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SendOtpCubit, SendOtpState>(
          listener: (context, state) {
            if (state is SendOtpSuccessfuly) {
              SnackBars.Success(context, "Otp Sent successfully");
            } else if (state is SendOtpInternetError) {
              SnackBars.Danger(context, "Internet connection failed");
            } else if (state is SendOtpFailed) {
              SnackBars.Danger(context, "Otp sent failed");
            } else if (state is SendOtpTimeOut) {
              SnackBars.Danger(context, "Request timeout");
            }
          },
        ),
        BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccessfull) {
              SnackBars.Success(context, "User account created successfully");
              Navigator.of(dialogueContext!).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const AccountCreatedScreen()));
            } else if (state is RegistrationAlreadyExist) {
              SnackBars.Success(context, "User account already exist");
              Navigator.of(dialogueContext!).pop();
            } else if (state is RegistrationInternetError) {
              SnackBars.Danger(context, "Internet connection failed");
              Navigator.of(dialogueContext!).pop();
            } else if (state is RegistrationFailed) {
              SnackBars.Danger(context, "User account creation failed");
              Navigator.of(dialogueContext!).pop();
            } else if (state is RegistrationTimeout) {
              SnackBars.Danger(context, "Request timeout");
              Navigator.of(dialogueContext!).pop();
            }
          },
        ),
        BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) async {
            if (state is VerifyEmailLoading) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_ctx) {
                    dialogueContext = _ctx;
                    return Dialog(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
            } else if (state is VerifyEmailSuccessfuly) {
              var registrationMap = {
                "f_name": "${widget.userModel.firstName}",
                "l_name": "${widget.userModel.lastName}",
                "phone": "${widget.userModel.phoneNumber}",
                "email": "${widget.userModel.email}",
                "password": "${widget.userModel.password}",
              };
              await registrationCubit.userRegistration(registrationMap);
            } else if (state is VerifyEmailFailed) {
              SnackBars.Success(context, "Invalid Verification Code");
              Navigator.of(dialogueContext!).pop();
            } else if (state is VerifyEmailInternetError) {
              SnackBars.Danger(context, "Internet connection failed");
              Navigator.of(dialogueContext!).pop();
            } else if (state is VerifyEmailTimeOut) {
              SnackBars.Danger(context, "Request timeout");
              Navigator.of(dialogueContext!).pop();
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const BasicAppbarWidget(
          title: AppText.verifyEmailAddress,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SecondaryTextWidget(
                    text:
                        "${AppText.resetPasswordText} ${widget.userModel.getEmail}"),
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
                BlocBuilder<OtpTimerCubit, OtpTimerState>(
                  builder: (context, state) {
                    if (state is OtpTimerRunning) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PrimaryTextWidget(
                            text: 'Resend in ${state.secondsValue} seconds',
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                        ],
                      );
                    } else if (state is OtpTimerStoppedShowButton) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SecondaryTextWidget(
                            text: 'Didn’t receive OTP? ',
                            fontSize: 13,
                          ),
                          GestureDetector(
                            onTap: () {
                              otpTimerCubit.startOtpIntervals();

                              sendOtpCubit.sendOtp(widget.userModel.getEmail);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 1.h,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: AppColors.primaryColor,
                                width: 0.5,
                              ))),
                              child: const PrimaryTextWidget(
                                text: 'Resend code',
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.verifyText,
                    onPressed: () async {
                      await verifyEmailCubit.verifyEmail(
                          widget.userModel.email, otpController.text.trim());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

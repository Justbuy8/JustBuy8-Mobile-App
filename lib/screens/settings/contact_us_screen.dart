// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:justbuyeight/blocs/contact_us/contact_us_cubit.dart';
import 'package:justbuyeight/blocs/support_cubit/support_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late SupportCubit supportCubit;
  BuildContext? dialogueContext;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    supportCubit = context.read<SupportCubit>();
    supportCubit.getSupportData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbarWidget(title: AppText.contactUsText),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: SingleChildScrollView(
            child: BlocListener<ContactUsCubit, ContactUsState>(
              listener: (context, state) {
                if (state is ContactUsLoading) {
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
                } else if (state is ContactUsSuccessfull) {
                  SnackBars.Success(
                      context, 'Your message has been send successfully');

                  DismissLoadingDialog(dialogueContext);
                } else if (state is ContactUsInternetError) {
                  SnackBars.Danger(context, AppText.internetError);
                  DismissLoadingDialog(dialogueContext);
                } else if (state is ContactUsFailed) {
                  SnackBars.Danger(context, 'Contact us failed');
                  DismissLoadingDialog(dialogueContext);
                } else if (state is ContactUsTimeout) {
                  SnackBars.Danger(context, AppText.timeOut);
                  DismissLoadingDialog(dialogueContext);
                }
              },
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Image.asset(
                      ImageAssets.contactUsImage,
                      height: 150.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    PrimaryTextWidget(
                      text: AppText.contactUsText,
                      fontSize: 28,
                      fontFamily: AppFonts.openSansBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const SecondaryTextWidget(
                      text: AppText.contactUsSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFieldWidget(
                      controller: _subjectController,
                      label: 'Subject',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter subject";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFieldWidget(
                      controller: _messageController,
                      maxLine: 4,
                      label: 'Message',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter message";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButtonWidget(
                          width: context.width(),
                          height: 50.h,
                          caption: 'Send message',
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (formGlobalKey.currentState!.validate()) {
                              currentFocus.unfocus();
                              context.read<ContactUsCubit>().userContactUs(
                                  _subjectController.text.trim(),
                                  _messageController.text.trim());
                              _subjectController.clear();
                              _messageController.clear();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15.h,
                    ),
                    BlocBuilder<SupportCubit, SupportState>(
                        builder: (context, state) {
                      if (state is SupportLoading) {
                        return AppCircularSpinner();
                      } else if (state is SupportFailed) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(LottieAssets.error, height: 100.h),
                            Center(
                              child: PrimaryTextWidget(
                                text: 'Loading data failed',
                              ),
                            )
                          ],
                        );
                      } else if (state is SupportInternetError) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(LottieAssets.error, height: 100.h),
                            Center(
                              child: PrimaryTextWidget(
                                text: AppText.internetError,
                              ),
                            )
                          ],
                        );
                      } else if (state is SupportLoaded) {
                        return Column(
                          children: [
                            SupportDetailWidget(
                              title: state.supportData.first.data[0].address,
                              iconData: Icons.location_city,
                            ),
                            SupportDetailWidget(
                              title:
                                  state.supportData.first.data[0].companyName,
                              iconData: Icons.home,
                            ),
                            SupportDetailWidget(
                              title: state.supportData.first.data[0].email,
                              iconData: Icons.email,
                            ),
                            SupportDetailWidget(
                              title: state.supportData.first.data[0].phone,
                              iconData: Icons.phone,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SupportDetailWidget extends StatelessWidget {
  final String title;
  final IconData iconData;

  SupportDetailWidget({required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.iconbackgroundColor),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Icon(
                iconData,
                color: AppColors.primaryColor,
              ),
              SizedBox(
                width: 10.w,
              ),
              PrimaryTextWidget(text: title)
            ],
          ),
        ),
      ),
    );
  }
}

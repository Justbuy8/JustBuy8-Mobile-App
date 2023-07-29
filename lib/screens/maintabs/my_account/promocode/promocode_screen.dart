// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class PromodeCodeScreen extends StatefulWidget {
  const PromodeCodeScreen({Key? key}) : super(key: key);

  @override
  State<PromodeCodeScreen> createState() => _PromodeCodeScreenState();
}

class _PromodeCodeScreenState extends State<PromodeCodeScreen> {
  final TextEditingController _couponCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: 'My Promocodes'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///REUSED AGAIN///

                SizedBox(
                  height: 20.h,
                ),
                // Image.asset(
                //   ImageAssets.promocodeImage,
                //   color: Color.fromARGB(255, 146, 46, 46),
                // ),
                // SizedBox(
                //   height: 30.h,
                // ),
                // PrimaryTextWidget(
                //   text: AppText.dontHaveText,
                //   fontSize: 28,
                //   fontFamily: AppFonts.openSansBold,
                //   textAlign: TextAlign.center,
                // ),
                // PrimaryTextWidget(
                //   text: AppText.promocodeText,
                //   fontSize: 28,
                //   fontFamily: AppFonts.openSansBold,
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // const SecondaryTextWidget(text: AppText.promocodeSubTitleText),
                // SizedBox(
                //   height: 30.h,
                // ),
                TextFieldWidget(
                  controller: _couponCodeController,
                  prefixIcon: Icons.card_giftcard_outlined,
                  label: 'Enter Your Coupon Code',
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButtonWidget(
                      width: context.width(),
                      height: 50.h,
                      caption: AppText.promoCode,
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (builder) => MainTabsScreen()));
                      }),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.w),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.appGreyColor)),
                          child: Padding(
                            padding: EdgeInsets.all(15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.card_giftcard_outlined),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        PrimaryTextWidget(text: '20%'),
                                      ],
                                    ),
                                    Icon(Icons.copy),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SecondaryTextWidget(
                                        text: 'Expires Sep 20,2023'),
                                    SecondaryTextWidget(text: '20firstorder')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

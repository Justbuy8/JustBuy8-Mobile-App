import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';

import 'package:justbuyeight/screens/maintabs/cart/widgets/cart_card_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promocode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(
        title: AppText.cartText,
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              // Center(
              //   child: Image.asset(
              //     ImageAssets.emptyCart,
              //     height: context.height() * 0.3,
              //   ),
              // ),
              // 20.height,
              // Text(
              //   AppText.yourCartIsEmptyText,
              //   style: AppTextStyle.cartTextStyle,
              // ),
              // 10.height,
              // const Text(AppText.looksLikeYouHaventMadeYourOrderYetText),
              // 40.height,
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: AppColors.primaryColor),
              //     ),
              //     child: Text(
              //       AppText.shopNowText,
              //       style: TextStyle(
              //         color: AppColors.primaryColor,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CartCardWidget(),
                        Divider(),
                      ],
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 20.w),
                child: PrimaryTextWidget(
                  text: 'Promo Code',
                  fontSize: 15,
                  fontFamily: AppFonts.robotoBold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    Container(
                      height: 55.h,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFieldWidget(
                        controller: _promocode,
                        label: 'Enter Code Here',
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 50.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.black),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: 'Sub total',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '\$300.00',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: SecondaryTextWidget(
                      text: 'Discount',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '\$0.00',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: SecondaryTextWidget(
                      text: 'Delivery',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '+\$15.00',
                      fontSize: 14,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryTextWidget(
                          text: 'Total',
                          fontSize: 14,
                          fontFamily: AppFonts.robotoLight,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        PrimaryTextWidget(
                          text: '\$315.00',
                          fontSize: 14,
                          fontFamily: AppFonts.robotoLight,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.red)),
                        height: 40.h,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: PrimaryTextWidget(
                            text: 'Proceed To Checkout',
                            fontColor: Colors.red,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

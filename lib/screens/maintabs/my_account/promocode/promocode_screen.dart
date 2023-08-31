// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/cart/get_cart/get_cart_cubit.dart';
import 'package:justbuyeight/blocs/coupons_cubit/coupons_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
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

  late CouponsCubit couponsCubit;

  initCubit() {
    couponsCubit = context.read<CouponsCubit>();
    couponsCubit.getCoupons();
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: 'My Promocodes'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
            child: BlocBuilder<CouponsCubit, CouponsState>(
              builder: (context, state) {
                if (state is CouponsLoading) {
                  return Center(child: AppCircularSpinner());
                } else if (state is CouponsLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      state.couponsData.isEmpty
                          ? Column(
                              children: [
                                Image.asset(
                                  ImageAssets.promocodeImage,
                                  color: Color.fromARGB(255, 146, 46, 46),
                                  height: 100,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                PrimaryTextWidget(
                                  text: AppText.dontHaveText,
                                  fontSize: 26,
                                  fontFamily: AppFonts.openSansBold,
                                  textAlign: TextAlign.center,
                                ),
                                PrimaryTextWidget(
                                  text: AppText.promocodeText,
                                  fontSize: 26,
                                  fontFamily: AppFonts.openSansBold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                const SecondaryTextWidget(
                                    text: AppText.promocodeSubTitleText),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.couponsData.first.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    bool data = state.couponsData.first
                                        .data[index].expireDate
                                        .isAfter(DateTime.now());
                                    if (data) {
                                      context
                                          .read<GetCartCubit>()
                                          .getCouponsInformation(state
                                              .couponsData.first.data[index]);
                                      Navigator.pop(context);
                                    } else {
                                      SnackBars.Danger(
                                          context, 'You coupons is expire.');
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.appGreyColor)),
                                      child: Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .card_giftcard_outlined,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    PrimaryTextWidget(
                                                      text:
                                                          '${state.couponsData.first.data[index].title}',
                                                    ),
                                                  ],
                                                ),
                                                PrimaryTextWidget(
                                                    text:
                                                        '${state.couponsData.first.data[index].code}'),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                state.couponsData.first
                                                        .data[index].expireDate
                                                        .isAfter(DateTime.now())
                                                    ? SecondaryTextWidget(
                                                        text:
                                                            'Expires in ${state.couponsData.first.data[index].expireDate.toString().substring(0, 11)}')
                                                    : SecondaryTextWidget(
                                                        text:
                                                            '${state.couponsData.first.data[index].expireDate.toString().substring(0, 11)}',
                                                        fontColor: AppColors
                                                            .appRedColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                Row(
                                                  children: [
                                                    SecondaryTextWidget(
                                                        text:
                                                            '${state.couponsData.first.data[index].discount.toString()}'),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    state
                                                                .couponsData
                                                                .first
                                                                .data[index]
                                                                .discountType ==
                                                            "amount"
                                                        ? Icon(
                                                            Ionicons
                                                                .cash_outline,
                                                            color: AppColors
                                                                .primaryColor,
                                                          )
                                                        : Icon(
                                                            Icons.percent,
                                                            color: AppColors
                                                                .primaryColor,
                                                          )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

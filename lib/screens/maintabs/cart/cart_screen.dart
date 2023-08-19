// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/cart/get_cart/get_cart_cubit.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/screens/maintabs/cart/checkout_screen.dart';
import 'package:justbuyeight/screens/maintabs/cart/widgets/cart_card_widget.dart';
import 'package:justbuyeight/screens/maintabs/cart/widgets/promo_code_widget.dart';

import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promocode = TextEditingController();
  late GetCartCubit controller;
  int? totalPrice;
  int? discountPrice;
  int? finalPrice;
  int? deliveryCharges;
  int? tax;

  initCubit() {
    controller = context.read<GetCartCubit>();
    controller.getCart();
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetCartCubit, GetCartState>(
      listener: (context, state) {
        if (state is GetCartQuantityIncreases) {
          controller.getCart();
        } else if (state is GetCartQuantityDecreases) {
          controller.getCart();
        } else if (state is GetCartDeleted) {
          controller.getCart();
        }
      },
      child: Scaffold(
        appBar: const SecondaryAppbarWidget(
          title: AppText.cartText,
          leadingIcon: Ionicons.settings_outline,
          trailingIcon: Ionicons.notifications_outline,
        ),
        body: BlocBuilder<GetCartCubit, GetCartState>(
          builder: (context, state) {
            if (state is GetCartLoading) {
              return state.cartData.length == 0
                  ? AppCircularSpinner()
                  : getCartWidget(state, context);
            } else if (state is GetCartLoaded) {
              totalPrice = 0;
              discountPrice = 0;
              deliveryCharges = 0;
              tax = 0;
              finalPrice = 0;
              for (var i = 0; i < state.cartData.first.data.length; i++) {
                totalPrice = (totalPrice! +
                    int.parse(state.cartData.first.data[i].price.toString()));
                discountPrice = (discountPrice! +
                    int.parse(
                        state.cartData.first.data[i].discount.toString()));
                deliveryCharges = (deliveryCharges! +
                    int.parse(
                        state.cartData.first.data[i].shippingCost.toString()));
                tax = (tax! +
                    int.parse(state.cartData.first.data[i].tax.toString()));
              }
              finalPrice = totalPrice! + deliveryCharges! + tax!;

              return getCartWidget(state, context);
            } else if (state is GetCartFailed) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(LottieAssets.error, height: 200.h),
                  Center(
                    child: PrimaryTextWidget(
                      text: 'Loading data failed',
                    ),
                  )
                ],
              );
            } else if (state is GetNoCartFound) {
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Image.asset(
                        ImageAssets.emptyCart,
                        height: context.height() * 0.3,
                      ),
                    ),
                    20.height,
                    Text(
                      AppText.yourCartIsEmptyText,
                      style: AppTextStyle.cartTextStyle,
                    ),
                    10.height,
                    const Text(AppText.looksLikeYouHaventMadeYourOrderYetText),
                    40.height,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Text(
                          AppText.shopNowText,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is GetCartInternetError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(LottieAssets.error, height: 200.h),
                  Center(
                    child: PrimaryTextWidget(
                      text: AppText.internetError,
                    ),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  RefreshIndicator getCartWidget(var state, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getCart();
      },
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),
              ListView.builder(
                  itemCount: state.cartData.first.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GetCartCardWidget(
                      getCartCubit: controller,
                      state: state,
                      index: index,
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              PromoCodeWidget(
                controller: _promocode,
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
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '${totalPrice} \$',
                      fontSize: 16,
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
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '-0 \$',
                      fontSize: 16,
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
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '+${deliveryCharges} \$',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.red,
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
                      text: 'Tax',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: PrimaryTextWidget(
                      text: '+${tax} \$',
                      fontSize: 16,
                      fontFamily: AppFonts.robotoLight,
                      fontColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(),
              SizedBox(
                height: 10.h,
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
                          fontSize: 16,
                          fontFamily: AppFonts.robotoLight,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        PrimaryTextWidget(
                          text: '${finalPrice} \$',
                          fontSize: 16,
                          fontFamily: AppFonts.robotoLight,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => CheckOutScreen()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          height: 40.h,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: PrimaryTextWidget(
                              text: 'Proceed To Checkout',
                              fontColor: AppColors.primaryColor,
                            ),
                          )),
                    ),
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

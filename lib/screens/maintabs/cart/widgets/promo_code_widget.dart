import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/cart/get_cart/get_cart_cubit.dart';
import 'package:justbuyeight/blocs/coupons_cubit/coupons_cubit.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/screens/maintabs/my_account/promocode/promocode_screen.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class PromoCodeWidget extends StatefulWidget {
  final TextEditingController controller;

  PromoCodeWidget({
    required this.controller,
  });

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  readOnly: true,
                  controller: widget.controller,
                  label: 'Coupon code',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              widget.controller.text.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        bottomSheet();
                      },
                      child: Container(
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
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.controller.clear();
                          context
                              .read<GetCartCubit>()
                              .getCouponsInformation(null);
                        });
                      },
                      child: Container(
                        height: 50.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.red),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Future<void> bottomSheet() {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: PromodeCodeScreen(),
            ),
          ],
        );
      },
    );
  }
}

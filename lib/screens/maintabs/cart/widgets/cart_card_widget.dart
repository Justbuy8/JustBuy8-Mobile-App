// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/cart/get_cart/get_cart_cubit.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class GetCartCardWidget extends StatelessWidget {
  GetCartCardWidget({
    Key? key,
    required this.getCartCubit,
    this.state,
    required this.index,
  }) : super(key: key);

  final GetCartCubit getCartCubit;
  var state;
  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140.h,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 5.w),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Image.network(
                          state.cartData.first.data[index].thumbnail,
                          height: 130.h,
                          width: 100.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: context.width() / 1.8,
                          child: PrimaryTextWidget(
                            text: state.cartData.first.data[index].productName,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        PrimaryTextWidget(
                          text:
                              '${state.cartData.first.data[index].price - state.cartData.first.data[index].discount} \$',
                          fontSize: 14,
                          fontFamily: AppFonts.robotoBold,
                        ),
                        state.cartData.first.data[index].variation != null
                            ? (state.cartData.first.data[index].variation!.color
                                        .isNotEmpty ||
                                    state.cartData.first.data[index].variation!
                                        .size!.isNotEmpty)
                                ? SizedBox(
                                    height: 10.h,
                                  )
                                : SizedBox()
                            : SizedBox(),
                        state.cartData.first.data[index].variation != null
                            ? SecondaryTextWidget(
                                text:
                                    '${state.cartData.first.data[index].variation!.color.isEmpty ? '' : 'Color ${state.cartData.first.data[index].variation!.color} '}  ${state.cartData.first.data[index].variation!.size == null ? '' : '| Size ${state.cartData.first.data[index].variation!.size}'}',
                                fontSize: 12,
                              )
                            : SizedBox(),
                        state.cartData.first.data[index].variation != null
                            ? (state.cartData.first.data[index].variation!.color
                                        .isNotEmpty ||
                                    state.cartData.first.data[index].variation!
                                        .size!.isNotEmpty)
                                ? SizedBox(
                                    height: 10.h,
                                  )
                                : SizedBox()
                            : SizedBox(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                state.cartData.first.data[index].quantity == '1'
                                    ? null
                                    : getCartCubit.decrementinQuantity(state
                                        .cartData.first.data[index].cartId);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(
                                  Ionicons.remove,
                                  color:
                                      const Color.fromARGB(255, 141, 141, 141),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Container(
                                width: 50.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: const Color.fromARGB(
                                        255, 227, 225, 225)),
                                child: Center(
                                  child: PrimaryTextWidget(
                                    text:
                                        '${state.cartData.first.data[index].quantity}',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                getCartCubit.incrementinQuantity(
                                    state.cartData.first.data[index].cartId);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(
                                  Icons.add,
                                  color:
                                      const Color.fromARGB(255, 141, 141, 141),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        getCartCubit.deleteCartItem(
                            state.cartData.first.data[index].cartId);
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

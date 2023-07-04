// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class CompletedCardWidget extends StatelessWidget {
  const CompletedCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.iconbackgroundColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.network(
                      "https://cdn.shopify.com/s/files/1/0344/8442/0748/files/DPCH-230-_6_600x.jpg?v=1684404363",
                      height: 110.h,
                      width: 100.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryTextWidget(
                      text: 'Premium womens georgette',
                      fontSize: 15,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SecondaryTextWidget(
                      text: 'Color: tilt | Size: M | Qty: 1',
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 222, 222),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: PrimaryTextWidget(
                          text: 'In Delivery',
                          fontSize: 12,
                          fontColor: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryTextWidget(
                            text: '\$150',
                            fontSize: 14,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: PrimaryTextWidget(
                                text: 'Leave Review',
                                fontSize: 12,
                                fontColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

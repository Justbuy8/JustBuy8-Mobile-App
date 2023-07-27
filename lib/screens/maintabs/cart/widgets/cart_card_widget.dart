// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class CartCardWidget extends StatelessWidget {
  const CartCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
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
                      height: 130.h,
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
                      text: 'Premium womens georgette\na-line knee long',
                      fontSize: 15,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextWidget(
                      text: '\$150',
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SecondaryTextWidget(
                      text: 'Color: tilt | Size: M ',
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            Ionicons.remove,
                            color: const Color.fromARGB(255, 141, 141, 141),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                            width: 50.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color:
                                    const Color.fromARGB(255, 227, 225, 225)),
                            child: Center(
                              child: PrimaryTextWidget(
                                text: '5',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            Icons.add,
                            color: const Color.fromARGB(255, 141, 141, 141),
                          ),
                        ),
                      ],
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

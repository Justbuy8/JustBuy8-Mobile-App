// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CartCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final String quantity;
  final String color;
  final String size;

  const CartCardWidget(
      {Key? key,
      required this.title,
      required this.image,
      required this.price,
      required this.quantity,
      required this.color,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
            child: Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.network(
                      image,
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
                    Container(
                      width: context.width() / 2,
                      child: PrimaryTextWidget(
                        text: title,
                        fontSize: 15,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextWidget(
                      text: price,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SecondaryTextWidget(
                      text: 'Color: ${color} | Size: ${size} ',
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
                                text: '${quantity}',
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

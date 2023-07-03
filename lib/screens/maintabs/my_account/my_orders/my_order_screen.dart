// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const BasicAppbarWidget(title: 'My Orders'),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: AppColors.primaryColor,
                tabs: [
                  Tab(
                    text: 'Ongoing',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                OrderCardWidget(),
                                Divider(),
                              ],
                            );
                          }),
                    ),
                  )),

                  // second tab bar viiew widget
                  Container(
                    child: Center(
                      child: Text(
                        'Car',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
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
                    Container(
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
                                text: 'Track Orders',
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

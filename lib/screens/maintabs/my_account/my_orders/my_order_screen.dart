// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/completed_order_screen.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/widgets/completed_card_widgets.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/widgets/ongoing_card_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:page_transition/page_transition.dart';

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
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: CompletedOrderScreen()));
                                    },
                                    child: CompletedCardWidget()),
                                Divider(),
                              ],
                            );
                          }),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

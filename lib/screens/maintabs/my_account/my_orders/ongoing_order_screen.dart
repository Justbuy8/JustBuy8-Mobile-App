// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/widgets/completed_card_widgets.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/widgets/ongoing_card_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/seconday_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OnGoingOrderScreen extends StatefulWidget {
  const OnGoingOrderScreen({Key? key}) : super(key: key);

  @override
  State<OnGoingOrderScreen> createState() => _OnGoingOrderScreenState();
}

class _OnGoingOrderScreenState extends State<OnGoingOrderScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'Track Order'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          OrderCardWidget(),
          SizedBox(
            height: 10.h,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: PrimaryTextWidget(
              text: 'Order Status Details',
              fontSize: 18.sp,
              fontFamily: AppFonts.robotoBold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return TimelineTile(
                    alignment: TimelineAlign.start,
                    lineXY: 0.1,
                    isFirst: index == 0,
                    isLast: index == 5,
                    indicatorStyle: IndicatorStyle(
                      width: 20,
                      height: 20,
                      drawGap: true,
                      color: AppColors.primaryColor,
                    ),
                    beforeLineStyle: LineStyle(
                      color: AppColors.primaryColor,
                    ),
                    endChild: GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: PrimaryTextWidget(
                                      text: 'Order in Transit - April 17',
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: SecondaryTextWidget(
                                      text: '20:30 PM',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SecondaryTextWidget(
                                text: '32 Manchester, GA 7212',
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

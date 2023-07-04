// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/screens/maintabs/my_account/my_orders/widgets/completed_card_widgets.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/seconday_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({Key? key}) : super(key: key);

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'Live A Review'),
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          CompletedCardWidget(),
          SizedBox(
            height: 10.h,
          ),
          Divider(),
          PrimaryTextWidget(
            text: 'How is your order?',
            fontSize: 28.sp,
            fontFamily: AppFonts.robotoBold,
          ),
          SizedBox(
            height: 10.h,
          ),
          SecondaryTextWidget(
            text: 'Please leave a review for your course',
            fontSize: 15.sp,
          ),
          SizedBox(
            height: 20.h,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: AppColors.primaryColor,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
              padding: EdgeInsets.all(20.w),
              child: TextFieldWidget(
                controller: _messageController,
                maxLine: 6,
              )),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                child: SecondaryButtonWidget(
                    width: 150.w,
                    height: 50.h,
                    caption: 'Cancel',
                    onPressed: () async {}),
              ),
              SizedBox(
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                child: PrimaryButtonWidget(
                    width: 150.w,
                    height: 50.h,
                    caption: 'Submit',
                    onPressed: () async {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

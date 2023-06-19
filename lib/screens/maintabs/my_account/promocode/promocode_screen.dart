// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';

import 'package:justbuyeight/screens/maintabs/main_tabs_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class PromodeCodeScreen extends StatefulWidget {
  const PromodeCodeScreen({Key? key}) : super(key: key);

  @override
  State<PromodeCodeScreen> createState() => _PromodeCodeScreenState();
}

class _PromodeCodeScreenState extends State<PromodeCodeScreen> {
  final TextEditingController _couponCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: 'My Promocodes'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                ImageAssets.promocodeImage,
                color: Color.fromARGB(255, 146, 46, 46),
              ),
              SizedBox(
                height: 30.h,
              ),
              PrimaryTextWidget(
                text: AppText.dontHaveText,
                fontSize: 28,
                fontFamily: AppFonts.openSansBold,
                textAlign: TextAlign.center,
              ),
              PrimaryTextWidget(
                text: AppText.promocodeText,
                fontSize: 28,
                fontFamily: AppFonts.openSansBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              const SecondaryTextWidget(text: AppText.promocodeSubTitleText),
              SizedBox(
                height: 30.h,
              ),
              TextFieldWidget(
                controller: _couponCodeController,
                prefixIcon: Icons.card_giftcard_outlined,
                label: 'Enter Your Coupon Code',
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButtonWidget(
                    width: context.width(),
                    height: 50.h,
                    caption: AppText.promoCode,
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (builder) => MainTabsScreen()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

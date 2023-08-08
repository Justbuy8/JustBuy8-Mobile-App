import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({Key? key}) : super(key: key);

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'Special Offers'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.appGreyColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextWidget(
                                  text: '30% Off',
                                  fontSize: 32,
                                  fontFamily: AppFonts.robotoBold,
                                ),
                                PrimaryTextWidget(
                                  text: 'Today\'s Special',
                                  fontSize: 22,
                                  fontFamily: AppFonts.robotoRegular,
                                ),
                                SizedBox(height: 20),
                                SecondaryTextWidget(
                                    text: 'Get discount for every order'),
                                SecondaryTextWidget(
                                    text: 'Only valid for today')
                              ],
                            ),
                            Image.asset(
                              'assets/images/headfone.png',
                              height: 150,
                              width: 150,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

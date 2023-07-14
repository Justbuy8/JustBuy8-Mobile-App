import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/settings/about_us_screen.dart';
import 'package:justbuyeight/screens/settings/contact_us_screen.dart';
import 'package:justbuyeight/screens/settings/faqs_screen.dart';
import 'package:justbuyeight/screens/settings/notification_setting_screen.dart';
import 'package:justbuyeight/screens/settings/privacy_policy_screen.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:page_transition/page_transition.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: AppText.setting),
      body: ListView.builder(
          itemCount: myAccountListTitle.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                          child: NotificationSettingScreen()));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                          child: AboutUsScreen()));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                          child: PrivacyPolicyScreen()));
                } else if (index == 3) {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                          child: FaqScreen()));
                } else {
                  [
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 400),
                            type: PageTransitionType.rightToLeft,
                            child: ContactUsScreen()))
                  ];
                }
              },
              child: Column(
                children: [
                  ListTile(
                    title: PrimaryTextWidget(
                      text: settingListTitle[index],
                      fontSize: 14,
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                          color: AppColors.iconbackgroundColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          settingListIcon[index],
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                  ),
                  const Divider()
                ],
              ),
            );
          }),
    );
  }
}

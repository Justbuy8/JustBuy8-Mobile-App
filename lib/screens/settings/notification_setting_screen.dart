import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: AppText.notificationOption),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notificationOptionTitle.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SecondaryTextWidget(
                                text: notificationOptionTitle[index]),
                            CupertinoSwitch(
                              value: notificationOptionStatus[index],
                              onChanged: (value) {
                                notificationOptionStatus[index] = value;
                                setState(
                                  () {},
                                );
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

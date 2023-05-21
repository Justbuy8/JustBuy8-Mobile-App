import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/images/avatar_image_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const SecondaryAppbarWidget(
        trailingIcon: Icons.notifications_outlined,
        leadingIcon: Icons.settings_outlined,
        title: 'My Account',
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AvatarImageWidget(
                  height: 80,
                  width: 80,
                  imageUrl:
                      'https://lesley.edu/sites/default/files/styles/person_profile_1x_wid/public/Fisiha-Likke-Design-Faculty.png?h=f0d95172&itok=9iIy13RK',
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: context.width() / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PrimaryTextWidget(
                        text: 'Jessica Smith',
                      ),
                      SecondaryTextWidget(
                        text: 'Freelancer',
                        fontColor: Colors.grey,
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    size: 10.sp,
                  ),
                  padding: EdgeInsets.all(5.w),
                  shape: CircleBorder(),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

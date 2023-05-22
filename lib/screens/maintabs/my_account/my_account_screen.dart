// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/images/avatar_image_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvatarImageWidget(
                  imageUrl:
                      'https://lesley.edu/sites/default/files/styles/person_profile_1x_wid/public/Fisiha-Likke-Design-Faculty.png?h=f0d95172&itok=9iIy13RK',
                ),
                Column(
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
                SizedBox(
                  width: 20.w,
                ),
                MaterialButton(
                  onPressed: () {},
                  color: AppColors.iconbackgroundColor,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.mode_edit,
                    size: 15.sp,
                    color: AppColors.primaryColor,
                  ),
                  padding: EdgeInsets.all(5.w),
                  shape: const CircleBorder(),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
              child: ListView.builder(
                  itemCount: myAccountListTitle.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 5) {
                          [
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return confirmAlertDialog(
                                    context,
                                    'Confirm Logout',
                                    'Are you sure you want to logout?',
                                    YesPressed: () async {
                                  await UserSecureStorage.deleteSecureStorage();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              MultiBlocProvider(
                                                  providers:
                                                      BlocProviders.providers,
                                                  child: const SignInScreen())),
                                      (route) => false);
                                }, NoPressed: () {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ];
                        }
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: PrimaryTextWidget(
                              text: myAccountListTitle[index],
                              fontSize: 14,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.iconbackgroundColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  myAccountListIcon[index],
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
                  })),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(title: 'About Us'),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 10.h,
              ),
              SecondaryTextWidget(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF3b5998),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Ionicons.logo_facebook,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextWidget(text: 'Facebook')
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.purple,
                                Colors.pink,
                                Colors.orange,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Ionicons.logo_instagram,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextWidget(text: 'Instagram')
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Ionicons.logo_youtube,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextWidget(text: 'Youtube')
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF00acee),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Ionicons.logo_twitter,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextWidget(text: 'Twitter')
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

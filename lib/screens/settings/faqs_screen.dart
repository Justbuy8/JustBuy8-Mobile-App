import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BasicAppbarWidget(
        title: 'FAQs',
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: new PrimaryTextWidget(
                  text: 'Lorem Ipsum is simply dummy text',
                ),
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                collapsedTextColor: Colors.transparent,
                textColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SecondaryTextWidget(
                      text:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                    ),
                  ),
                ]),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: new PrimaryTextWidget(
                  text: 'Lorem Ipsum is simply dummy text',
                ),
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                collapsedTextColor: Colors.transparent,
                textColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SecondaryTextWidget(
                      text:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                    ),
                  ),
                ]),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: new PrimaryTextWidget(
                  text: 'Lorem Ipsum is simply dummy text',
                ),
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                collapsedTextColor: Colors.transparent,
                textColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SecondaryTextWidget(
                      text:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                    ),
                  ),
                ]),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: new PrimaryTextWidget(
                  text: 'Lorem Ipsum is simply dummy text',
                ),
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                collapsedTextColor: Colors.transparent,
                textColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SecondaryTextWidget(
                      text:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

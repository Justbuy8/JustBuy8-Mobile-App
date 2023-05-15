import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class AppCircularSpinner extends StatelessWidget {
  const AppCircularSpinner({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitThreeBounce(
          color: AppColors.primaryColor,
          size: 30.0,
        ),
      );
  }
}

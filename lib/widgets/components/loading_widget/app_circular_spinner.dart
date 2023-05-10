import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppCircularSpinner extends StatelessWidget {
  const AppCircularSpinner({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.primaryColor,
        secondRingColor: AppColors.secondaryColor,
        thirdRingColor: AppColors.successColor,
        size: 40,
      ),
    );
  }
}

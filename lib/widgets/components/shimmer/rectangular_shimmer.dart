import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RectangularShimmer extends StatelessWidget {
  const RectangularShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: const ShimmerDirection.fromLTRB(),
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.shimmerColor,
          ),
        ),
      ),
    );
  }
}

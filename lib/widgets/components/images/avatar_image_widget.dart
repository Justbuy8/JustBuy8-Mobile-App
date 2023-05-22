import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class AvatarImageWidget extends StatelessWidget {
  const AvatarImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // make it circle
      height: height ?? 100.h,
      width: width ?? 100.w,
      padding: EdgeInsets.all(5.0.w),
      decoration: BoxDecoration(
        color: AppColors.appGreyColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.appGreyColor.withOpacity(0.2),
          width: 2.0,
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(
          Ionicons.person_outline,
          size: 40.sp,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}

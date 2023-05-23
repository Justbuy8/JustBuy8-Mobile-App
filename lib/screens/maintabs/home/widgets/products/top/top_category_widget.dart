import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:nb_utils/nb_utils.dart';

class TopCategoryWidget extends StatelessWidget {
  const TopCategoryWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String icon;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: context.height() * 0.2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: AppColors.appGreyColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.appWhiteColor,
              radius: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(icon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                group: AutoSizeGroup(),
                maxFontSize: 12.sp,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.topCategoriesStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

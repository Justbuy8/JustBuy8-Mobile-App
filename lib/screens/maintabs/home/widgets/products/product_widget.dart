import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.text,
    required this.imageUrl,
    required this.oldPrice,
    required this.rating,
    required this.newPrice,
    required this.isFavourite,
  }) : super(key: key);
  final String text;
  final String imageUrl;
  final String oldPrice, rating;
  final double newPrice;
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: context.width() * 0.4,
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              color: AppColors.appGreyColor,
            ),
            child: GridTile(
              header: GridTileBar(
                leading: const SizedBox.shrink(),
                title: const SizedBox.shrink(),
                trailing: IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: AppColors.appWhiteColor,
                    radius: 15,
                    child: Icon(
                      isFavourite ? Ionicons.heart : Ionicons.heart_outline,
                      color: isFavourite
                          ? AppColors.appRedColor
                          : AppColors.appBlackColor,
                      size: 20,
                      shadows: [
                        Shadow(
                          color: AppColors.appBlackColor,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                  color: AppColors.appGreyColor,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: context.width() * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                text,
                style: TextStyle(
                  fontFamily: AppFonts.openSansBold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  AutoSizeText(
                    "\$$oldPrice",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      // delete the text
                      decoration: TextDecoration.lineThrough,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    "\$$newPrice",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      // delete the text
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Ionicons.star,
                        color: AppColors.primaryColor,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      AutoSizeText(
                        rating,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

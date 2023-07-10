// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/utils/Converts.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final bool? isWishlist;
  const ProductWidget({Key? key, required this.product, this.isWishlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
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
                      isWishlist == true
                          ? Ionicons.heart
                          : Ionicons.heart_outline,
                      color: isWishlist == true
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
                    image: CachedNetworkImageProvider(
                        product.thumbnail.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: context.width(),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                product.name.toString(),
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
                    "\$" + product.unitPrice.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      // delete the text
                      decoration: (product.discount.toDouble() > 0 &&
                              product.discount != null)
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    "\$" +
                        Converts.calculateProductPrice(
                                product.unitPrice.toDouble(),
                                product.discount.toDouble(),
                                product.discountType.toString())
                            .toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      // delete the text
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).visible(product.discount.toDouble() > 0 &&
                      product.discount != null),
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
                        product.totalRating.toString(),
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

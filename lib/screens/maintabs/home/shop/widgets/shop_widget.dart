// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopWidget extends StatelessWidget {
  final Shop shop;
  const ShopWidget({Key? key, required this.shop}) : super(key: key);

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
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                  color: AppColors.appGreyColor,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      shop.image.toString(),
                    ),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) => const SizedBox.shrink(),
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
                shop.name.toString(),
                style: TextStyle(
                  fontFamily: AppFonts.openSansBold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              // Row(
              //   children: [
              //     AutoSizeText(
              //       "\$" + shop.unitPrice.toString(),
              //       style: TextStyle(
              //         fontSize: 14.sp,
              //         fontWeight: FontWeight.w500,
              //         // delete the text
              //         decoration: (shop.discount.toDouble() > 0 &&
              //                 shop.discount != null)
              //             ? TextDecoration.lineThrough
              //             : null,
              //       ),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //     const SizedBox(width: 5),
              //     AutoSizeText(
              //       "\$" +
              //           Converts.calculateProductPrice(
              //                   shop.unitPrice.toDouble(),
              //                   shop.discount.toDouble(),
              //                   shop.discountType.toString())
              //               .toString(),
              //       style: TextStyle(
              //         fontSize: 14.sp,
              //         color: AppColors.primaryColor,
              //         fontWeight: FontWeight.w500,
              //         // delete the text
              //       ),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //     ).visible(
              //         shop.discount.toDouble() > 0 && shop.discount != null),
              //     const Spacer(),
              //     Row(
              //       children: [
              //         Icon(
              //           Ionicons.star,
              //           color: AppColors.primaryColor,
              //           size: 14,
              //         ),
              //         const SizedBox(width: 5),
              //         AutoSizeText(
              //           shop.totalRating.toString(),
              //           style: TextStyle(
              //             fontSize: 14.sp,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

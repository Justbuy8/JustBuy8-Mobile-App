// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/shop_details_screen.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/images/custom_cached_network_image.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopWidget extends StatelessWidget {
  final Shop shop;
  const ShopWidget({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.goToPage(
        context: context,
        screen: ShopDetailsScreen(shopId: shop.id!),
      ),
      child: Column(
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
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CustomCachedNetworkImage(
                      imageUrl: shop.image.toString(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "${shop.reviews} Reviews",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VxRating(
                      size: 10,
                      onRatingUpdate: (value) {},
                      count: 5,
                      selectionColor: AppColors.primaryColor,
                      isSelectable: false,
                      value: shop.reviews.toDouble(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

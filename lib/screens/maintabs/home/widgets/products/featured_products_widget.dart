import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/products/featured_products_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({
    Key? key,
    required this.text,
    required this.imageUrl,
    required this.price,
    required this.rating,
  }) : super(key: key);
  final String text;
  final String imageUrl;
  final String price, rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: context.height() * 0.2,
              width: context.width() * 0.4,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.appGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                height: context.height() * 0.2,
                width: context.width() * 0.4,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.appGreyColor,
                  child: Icon(
                    Ionicons.heart_outline,
                    color: AppColors.appBlackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: context.width() * 0.4,
          height: context.height() * 0.05,
          child: AutoSizeText(
            text,
            style: TextStyle(
              fontFamily: AppFonts.robotoBold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: context.width() * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$$price",
                style: TextStyle(
                  fontFamily: AppFonts.robotoBold,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Row(
                children: [
                  Icon(Ionicons.star, color: AppColors.primaryColor, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    rating,
                    style: TextStyle(
                      fontFamily: AppFonts.robotoBold,
                      fontSize: 16,
                    ),
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

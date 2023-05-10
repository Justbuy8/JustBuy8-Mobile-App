import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({
    Key? key,
    required this.text,
    required this.imageUrl,
  }) : super(key: key);
  final String text;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.height() * 0.2,
          width: context.width() * 0.4,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            height: context.height() * 0.2,
            width: context.width() * 0.4,
          ),
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
      ],
    );
  }
}

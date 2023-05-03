import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.boxFit,
    this.height,
    this.width,
    this.border,
  }) : super(key: key);
  final String imageUrl;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final BoxFit? boxFit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.height() * 0.3,
      width: width ?? context.width(),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.appGreyColor.withOpacity(0.2),
        border: border,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.contain,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.colorBurn,
              ),
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(20),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

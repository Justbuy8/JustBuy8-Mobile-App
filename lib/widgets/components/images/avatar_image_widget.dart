import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

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
      height: height ?? 100,
      width: width ?? 100,
      padding: const EdgeInsets.all(5.0),
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
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.colorBurn,
              ),
            ),
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

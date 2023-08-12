import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {Key? key, required this.imageUrl, this.placeholder})
      : super(key: key);

  final String imageUrl;
  final IconData? placeholder;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.toString(),
      cacheKey: imageUrl.toString(),
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Icon(placeholder ?? Ionicons.image_outline),
      errorWidget: (context, url, error) =>
          Icon(Ionicons.image_outline, size: 50),
    );
  }
}

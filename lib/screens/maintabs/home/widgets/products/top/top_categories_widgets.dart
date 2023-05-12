import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

const List<IconData> topCategoriesIcons = [
  Ionicons.shirt_outline,
  Ionicons.phone_portrait_outline,
  Ionicons.game_controller_outline,
  Ionicons.color_palette_outline,
  Ionicons.heart_outline,
  Ionicons.restaurant_outline,
  Ionicons.fitness_outline,
  Ionicons.football_outline,
];

const List<String> topCategoriesTexts = [
  "Fashion",
  "Electronics",
  "Toys",
  "Cosmetics",
  "Jewelry",
  "Kitchen",
  "Fitness",
  "Sports",
];

class TopCategoriesWidget extends StatelessWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height() * 0.3,
      child: GridView.builder(
        itemCount: topCategoriesIcons.length,
        // disable scrolling
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TopCategoryWidget(
            icon: topCategoriesIcons[index],
            text: topCategoriesTexts[index],
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}

class TopCategoryWidget extends StatelessWidget {
  const TopCategoryWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: AppColors.appGreyColor,
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.appWhiteColor,
              radius: 30,
              child: Icon(
                icon,
                color: AppColors.appBlackColor,
                size: 50,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

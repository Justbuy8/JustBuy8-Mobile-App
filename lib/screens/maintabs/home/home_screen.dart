// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/brands/choose_brands_screen.dart';
import 'package:justbuyeight/screens/categories/all_categories_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/best/best_products.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured/featured_products_listview.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/new_arrival/new_arrival_grid.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/top/top_categories_widgets.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/title-button/title_and_button_widget.dart';
import 'package:justbuyeight/screens/products/all_best_products_screen.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/category/categories_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppbarWidget(
        title: "JustBuy8",
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// main banner
            MainBannerWidget(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// featured products
                  TitleAndButtonWidget(text: AppText.featuredProductsText),
                  SizedBox(height: 20),
                  FeaturedProductsListview(),
                  SizedBox(height: 20),

                  /// top categories
                  TitleAndButtonWidget(
                    text: AppText.topCategoriesText,
                    onPressed: () {
                      TabNavigator.withoutTabNavigator(
                        context: context,
                        screen: AllCategoriesScreen(),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  TopCategoriesWidget(),
                ],
              ),
            ),

            /// footer banner
            FooterBannerWidget(),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  /// Best products
                  TitleAndButtonWidget(
                    text: AppText.bestProductsText,
                    onPressed: () => TabNavigator.withoutTabNavigator(
                      context: context,
                      screen: AllBestProductsScreen(),
                    ),
                  ),
                  SizedBox(height: 20),
                  BestProducts(),
                  SizedBox(height: 20),

                  /// choose brands
                  TitleAndButtonWidget(
                    text: AppText.chooseBrandsText,
                    onPressed: () => TabNavigator.withoutTabNavigator(
                      context: context,
                      screen: ChooseBrandsScreen(),
                    ),
                  ),
                  SizedBox(height: 20),
                  BrandsWidget(),
                  SizedBox(height: 20),

                  /// new arrivals
                  TitleAndButtonWidget(
                    text: AppText.newArrivalsText,
                  ),
                  SizedBox(height: 20),
                  CategoriesWidget(),
                  SizedBox(height: 20),
                  NewArrivalGrid(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

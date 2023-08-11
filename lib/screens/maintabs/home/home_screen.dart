// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/refresh_token/refresh_token_cubit.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/home/brands/choose_brands_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/categories/all_categories_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/products/all_best_products_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/products/featured_products_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/products/new_arrivals_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/shops_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/widgets/all_shops_grid.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/best/best_products.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured/featured_products_listview.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/new_arrival/new_arrival_grid.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/top/top_categories_widgets.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/title-button/title_and_button_widget.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/category/categories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RefreshTokenCubit refreshTokenCubit;

  refreshingToken() {
    refreshTokenCubit = context.read<RefreshTokenCubit>();
    refreshTokenCubit.refreshAuthToken();
  }

  @override
  void initState() {
    refreshingToken();
    super.initState();
  }

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
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// featured products
                  TitleAndButtonWidget(
                    text: AppText.featuredProductsText,
                    onPressed: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: FeaturedProductsScreen(),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  FeaturedProductsListview(),
                  SizedBox(height: 24),

                  /// top categories
                  TitleAndButtonWidget(
                    text: AppText.topCategoriesText,
                    onPressed: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: AllCategoriesScreen(),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  TopCategoriesWidget(),
                ],
              ),
            ),

            /// footer banner
            FooterBannerWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  /// Best products
                  SizedBox(height: 24),
                  TitleAndButtonWidget(
                    text: AppText.bestProductsText,
                    onPressed: () => AppNavigator.goToPage(
                      context: context,
                      screen: AllBestProductsScreen(),
                    ),
                  ),
                  SizedBox(height: 16),
                  BestProducts(),
                  SizedBox(height: 24),

                  /// choose brands
                  TitleAndButtonWidget(
                    text: AppText.chooseBrandsText,
                    onPressed: () => AppNavigator.goToPage(
                      context: context,
                      screen: ChooseBrandsScreen(),
                    ),
                  ),
                  SizedBox(height: 16),
                  BrandsWidget(),
                  SizedBox(height: 24),

                  /// new arrivals
                  TitleAndButtonWidget(
                    text: AppText.newArrivalsText,
                    onPressed: () => AppNavigator.goToPage(
                      context: context,
                      screen: NewArrivalsScreen(),
                    ),
                  ),
                  SizedBox(height: 16),
                  CategoriesWidget(),
                  SizedBox(height: 16),
                  NewArrivalGrid(),
                  SizedBox(height: 16),
                  TitleAndButtonWidget(
                    text: AppText.shopsText,
                    onPressed: () => AppNavigator.goToPage(
                      context: context,
                      screen: ShopScreen(),
                    ),
                  ),
                  SizedBox(height: 16),
                  AllShopsGrid(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/bloc_provider.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:justbuyeight/screens/authentication/signin_screen.dart';
import 'package:justbuyeight/screens/brands/choose_brands_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured/featured_products_listview.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/new_arrival/new_arrival_grid.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/top/top_categories_widgets.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/title-button/title_and_button_widget.dart';
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button.dart';
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButtonWidget(
                  width: 100.w,
                  caption: 'Logout',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return confirmAlertDialog(context, 'Confirm Logout',
                            'Are you sure you want to logout?',
                            YesPressed: () async {
                          await UserSecureStorage.deleteSecureStorage();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (builder) => MultiBlocProvider(
                                      providers: BlocProviders.providers,
                                      child: SignInScreen())),
                              (route) => false);
                        }, NoPressed: () {
                          Navigator.of(context).pop();
                        });
                      },
                    );
                  },
                ),
              ),
            ),

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
                  TitleAndButtonWidget(text: AppText.topCategoriesText),
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
                  /// choose brands
                  TitleAndButtonWidget(
                    text: AppText.chooseBrandsText,
                    onPressed: () => TabNavigator.withoutTabNavigator(
                        context: context, screen: ChooseBrandsScreen()),
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

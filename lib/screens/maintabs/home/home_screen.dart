// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import 'package:justbuyeight/utils/AlertDialog.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/category/categories_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

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

  checkpermission_opencamera() async {
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    print(cameraStatus);
    print(microphoneStatus);
    //cameraStatus.isGranted == has access to application
    //cameraStatus.isDenied == does not have access to application, you can request again for the permission.
    //cameraStatus.isPermanentlyDenied == does not have access to application, you cannot request again for the permission.
    //cameraStatus.isRestricted == because of security/parental control you cannot use this permission.
    //cameraStatus.isUndetermined == permission has not asked before.

    if (!cameraStatus.isGranted) await Permission.camera.request();

    if (!microphoneStatus.isGranted) await Permission.microphone.request();

    if (await Permission.camera.isGranted) {
      if (await Permission.microphone.isGranted) {
        // openCamera();
      } else {
        // Toast(message:"Camera needs to access your microphone, please provide permission", position: ToastPosition.bottom);
      }
    } else {
      // showToast("Provide Camera permission to use camera.", position: ToastPosition.bottom);
    }
  }

  @override
  void initState() {
    checkpermission_opencamera();
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

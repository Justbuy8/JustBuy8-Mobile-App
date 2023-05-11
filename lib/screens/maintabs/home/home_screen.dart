import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/buttons/view_all_button.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured_products_listview.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/text/title_and_button_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(
        title: "Zoop Store",
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// main banner
            const MainBannerWidget(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// featured products
                  TitleAndButtonWidget(text: AppText.featuredProductsText),
                  const SizedBox(height: 20),
                  const FeaturedProductsListview(),

                  /// top categories
                  TitleAndButtonWidget(text: AppText.topCategoriesText),
                ],
              ),
            ),

            /// footer banner
            const FooterBannerWidget(),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  /// choose brands
                  TitleAndButtonWidget(text: AppText.chooseBrandsText),

                  /// new arrivals
                  TitleAndButtonWidget(text: AppText.newArrivalsText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/brands/brands_widget.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured/featured_products_listview.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/top/top_categories_widgets.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/title-button/title_and_button_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/FooterBannerWidget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SecondaryAppbarWidget(
        title: "JustBuy8",
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       /// main banner
      //       MainBannerWidget(),
      //       SizedBox(height: 20),
      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             /// featured products
      //             TitleAndButtonWidget(text: AppText.featuredProductsText),
      //             SizedBox(height: 20),
      //             FeaturedProductsListview(),
      //             SizedBox(height: 20),

      //             /// top categories
      //             TitleAndButtonWidget(text: AppText.topCategoriesText),
      //             SizedBox(height: 20),
      //             TopCategoriesWidget(),
      //           ],
      //         ),
      //       ),

      //       /// footer banner
      //       FooterBannerWidget(),

      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: Column(
      //           children: [
      //             /// choose brands
      //             TitleAndButtonWidget(text: AppText.chooseBrandsText),
      //             SizedBox(height: 20),
      //             BrandsWidget(),
      //             SizedBox(height: 60),

      //             /// new arrivals
      //             TitleAndButtonWidget(text: AppText.newArrivalsText),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

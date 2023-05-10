import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/screens/maintabs/widgets/buttons/view_all_button.dart';
import 'package:justbuyeight/screens/maintabs/widgets/text/title_text_widget.dart';
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
                  Row(
                    children: const [
                      TitleTextWidget(text: "Featured Products"),
                      Spacer(),
                      ViewAllButton(),
                    ],
                  ),

                  /// top categories
                  Row(
                    children: const [
                      TitleTextWidget(text: "Top Categories"),
                      Spacer(),
                      ViewAllButton(),
                    ],
                  ),
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
                  Row(
                    children: const [
                      TitleTextWidget(text: "Choose Brands"),
                      Spacer(),
                      ViewAllButton(),
                    ],
                  ),

                  /// new arrivals
                  Row(
                    children: const [
                      TitleTextWidget(text: "New Arrivals"),
                      Spacer(),
                      ViewAllButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

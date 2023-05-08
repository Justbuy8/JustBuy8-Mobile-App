import 'package:flutter/material.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/banners/MainBannerWidget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppbarWidget(
          title: "JustBuy8",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MainBannerWidget(),
            ],
          ),
        ));
  }
}

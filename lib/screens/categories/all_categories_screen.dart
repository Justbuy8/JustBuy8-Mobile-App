import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: "Categories"),
    );
  }
}

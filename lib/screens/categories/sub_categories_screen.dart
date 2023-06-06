import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String title;
  final int categoryId;
  const SubCategoriesScreen({
    Key? key,
    required this.title,
    required this.categoryId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: title),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(
        title: AppText.searchText,
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFieldWidget(
                          controller: searchController,
                          label: AppText.searchHereText,
                          prefixIcon: Ionicons.search_outline,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60.h,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              // an icon for filter
                              Ionicons.filter_outline,
                              color: AppColors.appWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

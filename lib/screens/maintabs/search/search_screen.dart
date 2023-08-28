import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/maintabs/search/widgets/rating_filter_widget.dart';
import 'package:justbuyeight/screens/maintabs/search/widgets/toggle_buttons_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/category/filter_categories_widget.dart';
import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> searchTypes = [
    AppText.saleText,
    AppText.trendingText,
    AppText.newText,
  ];

  RangeValues _currentRangeValues = const RangeValues(1, 200);

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();

    isSelected = List.generate(searchTypes.length, (index) => false);
  }

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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55.h,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFieldWidget(
                      controller: searchController,
                      label: 'Search Here',
                    ),
                  ),
                  10.widthBox,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        enableDrag: true,
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height / 1.2,
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ToggleButtonsWidget(
                                              searchTypes: searchTypes),
                                          const SizedBox(height: 20),
                                          Text(
                                            AppText.categoriesText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(height: 20),
                                          const FilterCategoriesWidget(),
                                          const SizedBox(height: 20),
                                          Text(
                                            AppText.priceText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          RangeSlider(
                                            values: _currentRangeValues,
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                _currentRangeValues = values;
                                              });
                                            },
                                            min: 1,
                                            max: 200,
                                            divisions: 200,
                                            labels: RangeLabels(
                                              "€${_currentRangeValues.start.round()}",
                                              "€${_currentRangeValues.end.round()}",
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            AppText.ratingText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(height: 20),
                                          const RatingFilterWidget(),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                PrimaryButtonWidget(
                                  caption: AppText.filterText,
                                  onPressed: () {
                                    // TODO: Close modal and apply filters
                                    context.pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.primaryColor),
                      child: Icon(
                        Ionicons.options_outline,
                        color: AppColors.appWhiteColor,
                      ),
                    ),
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

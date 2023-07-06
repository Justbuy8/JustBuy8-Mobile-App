import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/filter/widgets/rating_filter_widget.dart';
import 'package:justbuyeight/screens/filter/widgets/toggle_buttons_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/category/filter_categories_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.filterText),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ToggleButtonsWidget(searchTypes: searchTypes),
                      const SizedBox(height: 20),
                      Text(
                        AppText.categoriesText,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      const FilterCategoriesWidget(),
                      const SizedBox(height: 20),
                      Text(
                        AppText.priceText,
                        style: Theme.of(context).textTheme.titleLarge,
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
                        style: Theme.of(context).textTheme.titleLarge,
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

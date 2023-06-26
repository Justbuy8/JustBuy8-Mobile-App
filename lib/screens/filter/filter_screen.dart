import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/screens/filter/widgets/toggle_buttons_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtonsWidget(searchTypes: searchTypes),
                const SizedBox(height: 20),
                const PrimaryTextWidget(text: "Price"),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

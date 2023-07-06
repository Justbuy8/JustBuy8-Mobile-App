// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/categories/filter_categories/filter_categories_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

class FilterCategoriesWidget extends StatefulWidget {
  const FilterCategoriesWidget({Key? key}) : super(key: key);

  @override
  State<FilterCategoriesWidget> createState() => _FilterCategoriesWidgetState();
}

class _FilterCategoriesWidgetState extends State<FilterCategoriesWidget> {
  final Map<String, bool> categoryMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCategoriesBloc()
        ..add(
          FilterCategoriesLoadingEvent(
            page: AppConfig.PageOne.toString(),
            paginateBy: AppConfig.HomeBestNewArrivalPagenateCount.toString(),
            random: true,
          ),
        ),
      child: BlocConsumer<FilterCategoriesBloc, FilterCategoriesState>(
        listener: (context, state) {
          if (state is FilterCategoriesDataState) {
            categoryMap.addEntries(
              state.filterCategories.map(
                (e) => MapEntry(e.catName.toString(), false),
              ),
            );
            categoryMap['All'] = true;
          }
        },
        builder: (bloccontext, state) {
          if (state is FilterCategoriesDataState) {
            return SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.filterCategories.length,
                itemBuilder: (context, index) {
                  return BorderTextButton(
                    text: state.filterCategories[index].catName.toString(),
                    onPressed: () {
                      // make map true for this category and false for others
                      categoryMap.updateAll((key, value) => false);
                      categoryMap.update(
                        state.filterCategories[index].catName.toString(),
                        (value) => true,
                      );
                      setState(() {});
                    },
                    isClicked:
                        categoryMap[state.filterCategories[index].catName]!,
                  );
                },
              ),
            );
          }
          return const AppCircularSpinner();
        },
      ),
    );
  }
}

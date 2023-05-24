// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/categories/main_categories/main_category_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final Map<String, bool> categoryMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCategoryBloc()
        ..add(
          MainCategoryLoadingEvent(
              page: AppConfig.PageOne,
              paginateBy: AppConfig.HomeBestNewArrivalMainCatPagenateCount),
        ),
      child: BlocConsumer<MainCategoryBloc, MainCategoryState>(
        listener: (context, state) {
          BlocProvider.of<NewArrivalBloc>(context).add(NewArrivalGetAllEvent(
            AppConfig.PageOne,
            AppConfig.HomeBestNewArrivalPagenateCount,
            'all',
          ));
          if (state is MainCategoryDataState) {
            categoryMap.addEntries(
              state.mainCategory.map(
                (e) => MapEntry(e.catName.toString(), false),
              ),
            );
            categoryMap['All'] = true;
          }
        },
        builder: (bloccontext, state) {
          if (state is MainCategoryDataState) {
            return SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.mainCategory.length,
                itemBuilder: (context, index) {
                  return BorderTextButton(
                    text: state.mainCategory[index].catName.toString(),
                    onPressed: () {
                      BlocProvider.of<NewArrivalBloc>(bloccontext).add(
                        NewArrivalGetAllEvent(
                          "1",
                          "10",
                          state.mainCategory[index].catId.toString(),
                        ),
                      );
                      // make map true for this category and false for others
                      categoryMap.updateAll((key, value) => false);
                      categoryMap.update(
                        state.mainCategory[index].catName.toString(),
                        (value) => true,
                      );
                      setState(() {});
                    },
                    isClicked: categoryMap[state.mainCategory[index].catName]!,
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

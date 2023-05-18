import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/categories/main_categories/main_category_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';

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
          MainCategoryLoadingEvent(page: "1", paginateBy: "10"),
        ),
      child: BlocConsumer<MainCategoryBloc, MainCategoryState>(
        listener: (context, state) {
          if (state is MainCategoryDataState) {
            categoryMap.addEntries(
              state.mainCategory.map(
                (e) => MapEntry(e.catName.toString(), false),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MainCategoryDataState) {
            return SizedBox(
              // height: context.height() * 0.07,
              height: 45,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: state.mainCategory.length,
                itemBuilder: (context, index) => BorderTextButton(
                  text: state.mainCategory[index].catName.toString(),
                  onPressed: () {
                    BlocProvider.of<NewArrivalBloc>(context).add(
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
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

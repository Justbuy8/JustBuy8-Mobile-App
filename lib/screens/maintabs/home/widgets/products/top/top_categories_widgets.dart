import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/categories/top_catogeries/top_categories_bloc.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/top/top_category_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class TopCategoriesWidget extends StatelessWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopCategoriesBloc>(
      create: (context) =>
          TopCategoriesBloc()..add(TopCategoriesLoadingEvent()),
      child: BlocBuilder<TopCategoriesBloc, TopCategoriesState>(
        builder: (context, state) {
          if (state is TopCategoriesLoadingState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: const AppCircularSpinner(),
            );
          }
          if (state is TopCategoriesErrorState) {}
          if (state is TopCategoriesDataState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: GridView.builder(
                itemCount: state.topCategories.length,
                // disable scrolling
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TopCategoryWidget(
                    icon: state.topCategories[index].cateImage.toString(),
                    text: state.topCategories[index].catName.toString(),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/categories/sub_categories/sub_categories_bloc.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

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
        child: BlocProvider<SubCategoryBloc>(
          create: (context) => SubCategoryBloc()
            ..add(
              SubCategoryLoadingEvent(categoryId),
            ),
          child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
            builder: (context, state) {
              if (state is SubCategoryDataState) {
                return ListView.builder(
                  itemCount: state.subCategories.length,
                  itemBuilder: (context, index) {
                    return ExpansionPanelList.radio(
                      animationDuration: const Duration(milliseconds: 500),
                      children: [
                        ExpansionPanelRadio(
                          value: index,
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              title: Text(
                                state.subCategories[index].subCatName
                                    .toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          },
                          body: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.subCategories[index].child!.length,
                            itemBuilder: (context, subIndex) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    state.subCategories[index].child![subIndex]
                                        .childCatName
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is SubCategoryLoadingState) {
                return const AppCircularSpinner();
              } else if (state is SubCategoryErrorState) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

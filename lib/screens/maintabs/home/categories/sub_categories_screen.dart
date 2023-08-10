import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/categories/sub_categories/sub_categories_bloc.dart';
import 'package:justbuyeight/screens/maintabs/home/categories/widgets/SubCategoryListItemWidget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String title;
  final int categoryId;
  const SubCategoriesScreen({
    Key? key,
    required this.title,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final bloc = SubCategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: widget.title),
      body: SafeArea(
        child: BlocProvider<SubCategoryBloc>(
          create: (context) => bloc
            ..add(
              SubCategoryLoadingEvent(widget.categoryId),
            ),
          child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
            builder: (context, state) {
              if (state is SubCategoryDataState) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return SubCategoryListItemWidget(
                      categoryId: widget.categoryId,
                      subCategory: state.subCategories[index],
                    );
                  },
                  itemCount: state.subCategories.length,
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

/*children: [
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: context.width() / 2,
                              childAspectRatio: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) => BorderTextButton(
                              text: state
                                  .subCategories[index].child![i].childCatName
                                  .toString(),
                            ),
                            itemCount: state.subCategories[index].child!.length,
                          )
                        ],*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/categories/sub_categories/sub_categories_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/border_text_button.dart';
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
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ExpansionTile(
                          collapsedIconColor: AppColors.appWhiteColor,
                          childrenPadding: const EdgeInsets.all(10),
                          iconColor: AppColors.primaryColor,
                          collapsedBackgroundColor: AppColors.primaryColor,
                          textColor: AppColors.primaryColor,
                          collapsedTextColor: AppColors.appWhiteColor,
                          title: Text(
                            state.subCategories[index].subCatName.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 4.0,
                                mainAxisSpacing: 10.0,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.subCategories[index].child?.length,
                              itemBuilder: (context, i) {
                                return BorderTextButton(
                                  text: state.subCategories[index].child![i]
                                      .childCatName
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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

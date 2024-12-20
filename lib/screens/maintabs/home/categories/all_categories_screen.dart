// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_single_cascade_in_expression_statements, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/categories/all_categories/all_categories_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';
import 'package:justbuyeight/screens/maintabs/home/categories/sub_categories_screen.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.AllCategoriesPagenateCount;
  int page = AppConfig.PageOne;

  List<CategoryModel> categories = [];
  var categoriesBloc = AllCategoryBloc();

  @override
  void initState() {
    categoriesBloc = categoriesBloc
      ..add(AllCategoriesGetEvent(
        page: page.toString(),
        paginateBy: paginateBy.toString(),
        random: false,
      ));
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        categoriesBloc
          ..add(AllCategoriesGetEvent(
            page: page.toString(),
            paginateBy: paginateBy.toString(),
            random: false,
          ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.allCategoriesText),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener(
          bloc: categoriesBloc,
          listener: (context, state) {
            if (state is AllCategoryDataState) {
              setState(() {
                categories.addAll(state.allCategory);
              });
            }
            if (state is AllCategoryErrorState) {
              SnackBars.Danger(context, state.error);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: categories.isEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) =>
                            const RectangularShimmer(),
                        itemCount: 20,
                      )
                    : GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => AppNavigator.goToPage(
                                context: context,
                                screen: SubCategoriesScreen(
                                  title: categories[index].catName.toString(),
                                  categoryId: categories[index].catId.toInt(),
                                )),
                            child: CategoriyWidget(category: categories[index]),
                          );
                        },
                        itemCount: categories.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriyWidget extends StatelessWidget {
  const CategoriyWidget({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              color: AppColors.appGreyColor,
            ),
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                  color: AppColors.appGreyColor,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      category.cateImage.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          child: Text(
            category.catName.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
        ).paddingSymmetric(horizontal: 2),
        SizedBox(height: 3.h),
        SizedBox(
          // height: context.height() * 0.05,
          child: Text(
            "${category.productCount} ${AppText.itemsText}",
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ).paddingSymmetric(horizontal: 2),
      ],
    );
  }
}

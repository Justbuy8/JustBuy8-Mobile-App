// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_single_cascade_in_expression_statements, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/get_products_by_main_category/main_category_products_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class SingleCategoryScreen extends StatefulWidget {
  final CategoryModel category;
  const SingleCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.SingleCategoryPagenateCount;
  int page = AppConfig.PageOne;

  List<ProductModel> products = [];
  var categoriesBloc = MainCategoryProductsBloc();

  @override
  void initState() {
    categoriesBloc = categoriesBloc
      ..add(MainCategoryProductsLoadEvent(
        page.toString(),
        paginateBy.toString(),
        widget.category.catId.toInt(),
      ));
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        categoriesBloc
          ..add(MainCategoryProductsLoadEvent(
            page.toString(),
            paginateBy.toString(),
            widget.category.catId.toInt(),
          ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    categoriesBloc.close();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: widget.category.catName.toString()),
      body: SafeArea(
        child:
            BlocConsumer<MainCategoryProductsBloc, MainCategoryProductsState>(
          bloc: categoriesBloc,
          listener: (context, state) {
            if (state is MainCategoryProductsGetState) {
              products.addAll(state.products);
            }
          },
          builder: (context, state) {
            return products.isEmpty
                ? GridView.builder(
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return const RectangularShimmer();
                    },
                    padding: const EdgeInsets.all(10.0),
                  )
                : GridView.builder(
                    controller: _scrollController,
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return ProductWidget(product: products[index]);
                    },
                    padding: const EdgeInsets.all(10.0),
                  );
          },
        ),
      ),
    );
  }
}

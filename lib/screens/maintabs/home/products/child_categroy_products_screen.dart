import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/child_category_products_bloc/child_category_products_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/models/categories/SubCategoryModel.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';

class ChildCategoryProductsScreen extends StatefulWidget {
  final int categoryId;
  final SubCategoryModel subCategory;
  final Child childCategory;
  const ChildCategoryProductsScreen({
    Key? key,
    required this.categoryId,
    required this.subCategory,
    required this.childCategory,
  }) : super(key: key);

  @override
  State<ChildCategoryProductsScreen> createState() =>
      _ChildCategoryProductsScreenState();
}

class _ChildCategoryProductsScreenState
    extends State<ChildCategoryProductsScreen> {
  List<ProductModel> products = [];
  var bloc = ChildCategoryProductsBloc();

  final ScrollController scrollController = ScrollController();
  int paginateBy = AppConfig.ChildCategoryProductsPagenateCount;
  int page = AppConfig.PageOne;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        bloc.add(
          ChildCategoryProductsLoadEvent(
            page.toString(),
            paginateBy.toString(),
            widget.categoryId,
            widget.subCategory.subCatId!,
            widget.childCategory.childCatId!,
          ),
        );
      },
    );

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        bloc.add(
          ChildCategoryProductsLoadEvent(
            page.toString(),
            paginateBy.toString(),
            widget.categoryId,
            widget.subCategory.subCatId!,
            widget.childCategory.childCatId!,
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(
        title: widget.childCategory.childCatName.toString(),
      ),
      body: SafeArea(
        child:
            BlocConsumer<ChildCategoryProductsBloc, ChildCategoryProductsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ChildCategoryProductsGetState) {
              products.addAll(state.products);
            }
          },
          builder: (context, state) {
            if (state is ChildCategoryProductsErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return products.isEmpty
                ? Column(
                    children: [],
                  )
                : GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        product: products[index],
                      );
                    },
                    padding: const EdgeInsets.all(10.0),
                  );
          },
        ),
      ),
    );
  }
}

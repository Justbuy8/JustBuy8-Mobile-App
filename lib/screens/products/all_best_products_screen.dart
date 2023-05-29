import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/blocs/products/best/best_products_bloc.dart';
import 'package:justbuyeight/blocs/products/best/best_products_states_and_events.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/error/retry_error_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AllBestProductsScreen extends StatefulWidget {
  const AllBestProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllBestProductsScreen> createState() => _AllBestProductsScreenState();
}

class _AllBestProductsScreenState extends State<AllBestProductsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.HomeBestProductPagenateCount;
  int page = AppConfig.PageOne;

  List<ProductModel> products = [];
  var bloc = BestProductsBloc();

  @override
  void initState() {
    super.initState();
    bloc = bloc
      ..add(
        BestProductsGetAllEvent(page.toString(), paginateBy.toString(), false),
      );
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        bloc.add(
          BestProductsGetAllEvent(
              page.toString(), paginateBy.toString(), false),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.bestProductsText),
      body: BlocConsumer<BestProductsBloc, BestProductsState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is BestProductsGetAllState) {
            products.addAll(state.products);
          }
        },
        builder: (context, state) {
          if (state is BestProductsErrorState) {
            return RetryErrorWidget(errorMessage: state.message);
          }
          return products.isEmpty
              ? NoDataWidget()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox.expand(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ProductWidget(
                          product: products[index],
                        );
                      },
                      itemCount: products.length,
                    ),
                  ),
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_events_and_states.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class FeaturedProductsScreen extends StatefulWidget {
  const FeaturedProductsScreen({Key? key}) : super(key: key);

  @override
  State<FeaturedProductsScreen> createState() => _FeaturedProductsScreenState();
}

class _FeaturedProductsScreenState extends State<FeaturedProductsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();

  int paginateBy = AppConfig.HomeFeaturedProductsPageCount;
  int page = AppConfig.PageOne;

  List<ProductModel> products = [];
  var bloc = FeaturedProductsBloc();

  @override
  void initState() {
    super.initState();
    bloc = bloc
      ..add(FeaturedProductsLoadEvent(
          page.toString(), paginateBy.toString(), false));
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        bloc.add(FeaturedProductsLoadEvent(
          page.toString(),
          paginateBy.toString(),
          false,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.featuredProductsText),
      body: SafeArea(
        child: BlocConsumer<FeaturedProductsBloc, FeaturedProductsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is FeaturedProductsGetState) {
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

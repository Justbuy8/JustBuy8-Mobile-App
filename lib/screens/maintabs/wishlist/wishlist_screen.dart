import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/wishlist/wishlist_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/utils/AppDialog.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<ProductModel> products = [];

  final ScrollController scrollController = ScrollController();
  int paginateBy = AppConfig.WishListPagenateCount;
  int page = AppConfig.PageOne;

  callBloc() {
    context.read<WishlistBloc>().add(
          WishlistGetDataEvent(
            page: page,
            paginateBy: paginateBy,
          ),
        );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      callBloc();
    });

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        callBloc();
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
    return RefreshIndicator(
      onRefresh: () {
        products.clear();
        callBloc();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        appBar: SecondaryAppbarWidget(
          title: AppText.wishlistText,
          leadingIcon: Ionicons.settings_outline,
          trailingIcon: Ionicons.notifications_outline,
        ),
        body: SafeArea(
          child: BlocConsumer<WishlistBloc, WishlistState>(
            listener: (context, state) {
              if (state is WishlistLoadingState) {
                AppDialog.loadingDialog(context);
              } else if (state is WishlistGetState) {
                AppDialog.closeDialog();
                products.addAll(state.products);
              } else if (state is WishlistErrorState) {
                AppDialog.closeDialog();
              }
            },
            builder: (context, state) {
              if (state is WishlistErrorState) {
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
                          isWishlist: true,
                        );
                      },
                      padding: const EdgeInsets.all(10.0),
                    );
            },
          ),
        ),
      ),
    );
  }
}

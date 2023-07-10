import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/wishlist/wishlist_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<ProductModel> products = [];
  var wishlistBloc = WishlistBloc();

  String? userId;
  String? userToken;

  final ScrollController scrollController = ScrollController();
  int paginateBy = AppConfig.WishListPagenateCount;
  int page = AppConfig.PageOne;

  @override
  void initState() {
    // getting user id and user token
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
    });
    UserSecureStorage.fetchToken().then((value) {
      userToken = value;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      wishlistBloc.add(
        WishlistGetDataEvent(
          userId.toString(),
          userToken.toString(),
          page: page,
          paginateBy: paginateBy,
        ),
      );
    });

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        wishlistBloc.add(
          WishlistGetDataEvent(
            userId.toString(),
            userToken.toString(),
            page: page,
            paginateBy: paginateBy,
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    wishlistBloc.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppbarWidget(
        title: AppText.wishlistText,
        leadingIcon: Ionicons.settings_outline,
        trailingIcon: Ionicons.notifications_outline,
      ),
      body: SafeArea(
        child: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {
            if (state is WishlistGetState) {
              products.addAll(state.products);
            }
          },
          builder: (context, state) {
            if (state is WishlistErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
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
                    controller: scrollController,
                    padding: const EdgeInsets.all(10.0),
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
    );
  }
}

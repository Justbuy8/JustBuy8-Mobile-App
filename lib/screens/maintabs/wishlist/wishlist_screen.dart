import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/wishlist/delete_from_wishlist/delete_from_wishlist_bloc.dart';
import 'package:justbuyeight/blocs/wishlist/wishlist_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/utils/AppDialog.dart';
import 'package:justbuyeight/utils/AppToast.dart';
import 'package:justbuyeight/widgets/components/appbars/secondary_appbar_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class WishListScreen extends StatefulWidget {
  final List<ProductModel> products;
  const WishListScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final ScrollController scrollController = ScrollController();
  int paginateBy = AppConfig.WishListPagenateCount;
  int page = AppConfig.PageOne;

  DeleteFromWishlistBloc deleteFromWishlistBloc = DeleteFromWishlistBloc();

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
      widget.products.clear();
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
        widget.products.clear();
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
              if (state is WishlistGetState) {
                state.products.forEach((element) {
                  widget.products.add(element);
                });
              }
            },
            builder: (context, state) {
              if (state is WishlistErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is WishlistEmptyState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      LottieAssets.emptyproducts,
                      repeat: false,
                    ),
                    10.height,
                    Text(
                      AppText.noProductsFound,
                      style: AppTextStyle.heading,
                    ),
                  ],
                );
              }
              return widget.products.isEmpty
                  ? Column()
                  : BlocListener<DeleteFromWishlistBloc,
                      DeleteFromWishlistState>(
                      listener: (context, st) {
                        if (st is DeleteFromWishlistLoadingState) {
                          AppDialog.loadingDialog(context);
                        } else if (st is DeleteFromWishlistSuccessState) {
                          AppDialog.closeDialog();
                          AppToast.success(st.message);
                          widget.products.clear();
                          context.read<WishlistBloc>().add(
                                WishlistGetDataEvent(
                                  page: page,
                                  paginateBy: paginateBy,
                                ),
                              );
                        } else if (st is DeleteFromWishlistErrorState) {
                          AppDialog.closeDialog();
                          AppToast.danger(st.error);
                        }
                      },
                      child: GridView.builder(
                        itemCount: widget.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return ProductWidget(
                            product: widget.products[index],
                            isWishlist: true,
                          );
                        },
                        padding: const EdgeInsets.all(10.0),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

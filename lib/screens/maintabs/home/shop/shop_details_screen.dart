import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/products/get_product_by_shop/products_by_shop_bloc.dart';
import 'package:justbuyeight/blocs/shops/shop_details/shop_details_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/models/shop/ShopDetailsModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/utils/AppToast.dart';
import 'package:justbuyeight/utils/app_url_launcher.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopDetailsScreen extends StatefulWidget {
  final int shopId;
  const ShopDetailsScreen({Key? key, required this.shopId}) : super(key: key);
  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  int page = AppConfig.PageOne;
  int paginatedBy = 10;
  ShopDetailsBloc shopDetailsBloc = ShopDetailsBloc();
  ProductsByShopBloc productsByShopBloc = ProductsByShopBloc();
  ScrollController scrollController = ScrollController();
  List<ProductModel> products = [];
  String email = "";
  String contact = "";

  @override
  void initState() {
    shopDetailsBloc = shopDetailsBloc
      ..add(
        GetShopDetails(shopId: widget.shopId),
      );
    getInitialProductsBloc();
    super.initState();
  }

  getInitialProductsBloc() {
    productsByShopBloc = productsByShopBloc
      ..add(
        GetProductsByShopInitial(
          shopId: widget.shopId,
          page: page,
          paginateBy: paginatedBy,
        ),
      );
  }

  getMoreProductsBloc() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: "Shop Details"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    AppUrlLauncher.call(contact);
                  } catch (e) {
                    AppToast.danger(e.toString());
                  }
                },
                icon: Icon(Ionicons.call),
                label: Text("Call"),
              ),
            ),
            20.width,
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    AppUrlLauncher.email(email);
                  } catch (e) {
                    AppToast.danger(e.toString());
                  }
                },
                icon: Icon(Ionicons.mail),
                label: Text("Email"),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ShopDetailsBloc, ShopDetailsState>(
          bloc: shopDetailsBloc,
          listener: (context, state) {
            if (state is ShopDetailsLoaded) {
              email = state.shop.email.toString();
              contact = state.shop.contact.toString();
            }
          },
          builder: (context, state) {
            if (state is ShopDetailsLoading) {
              return Center(child: AppCircularSpinner());
            } else if (state is ShopDetailsFailed) {
              return Center(child: Text(state.message));
            } else if (state is ShopDetailsLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop Image and banner
                    TopBannerWidget(shop: state.shop),
                    Divider(thickness: 10),
                    10.height,
                    CustomListTile(
                      icon: Ionicons.time,
                      text: "Member since " +
                          DateFormat.yMMMM().format(
                            DateTime.parse(state.shop.memberSince.toString()),
                          ),
                    ),
                    Divider(thickness: 2),
                    20.height,
                    CustomListTile(
                      icon: Ionicons.location,
                      text: state.shop.address.toString(),
                    ),
                    Divider(thickness: 2),
                    20.height,
                    BlocConsumer(
                      bloc: productsByShopBloc,
                      listener: (context, state) {
                        if (state is ProductsByShopLoaded) {
                          products.addAll(state.products);
                        }
                      },
                      builder: (context, state) {
                        if (state is ProductsByShopLoading) {
                          return RectangularShimmerGridView(itemCount: 4);
                        } else if (state is ProductsByShopFailed) {
                          return Center(child: Text(state.message));
                        } else if (state is ProductsByShopEmpty) {
                          return Center(child: Text("No Products Found"));
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return ProductWidget(product: products[index]);
                            },
                            itemCount: products.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10.0),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomListTile({Key? key, required this.icon, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Icon(
          icon,
          color: AppColors.appBlackColor.withOpacity(0.3),
        )),
        Expanded(flex: 8, child: Text(text)),
      ],
    );
  }
}

class TopBannerWidget extends StatelessWidget {
  final ShopDetailsModel shop;
  const TopBannerWidget({Key? key, required this.shop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: shop.banner.toString(),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.appBlackColor.withOpacity(0.8),
                  AppColors.transparentColor,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 30,
                //   backgroundImage: CachedNetworkImageProvider(
                //     shop.image.toString(),
                //   ),
                // ),
                Container(
                  height: 80.h,
                  width: 100.w,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        shop.image.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: AppColors.appBlackColor,
                      width: 2,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name.toString(),
                      style: TextStyle(
                        color: AppColors.appWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   shop.address.toString(),
                    //   style: TextStyle(
                    //     color: AppColors.appWhiteColor,
                    //     fontSize: 15,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

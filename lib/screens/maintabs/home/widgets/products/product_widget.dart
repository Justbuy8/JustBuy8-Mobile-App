// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/wishlist/add_to_wishlist/add_to_wishlist_bloc.dart';
import 'package:justbuyeight/blocs/wishlist/delete_from_wishlist/delete_from_wishlist_bloc.dart';
import 'package:justbuyeight/blocs/wishlist/wishlist_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/products/products_details_screen.dart';
import 'package:justbuyeight/utils/AppToast.dart';
import 'package:justbuyeight/utils/Converts.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  final bool? isWishlist;
  const ProductWidget({Key? key, required this.product, this.isWishlist})
      : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int paginateBy = AppConfig.WishListPagenateCount;
  int page = AppConfig.PageOne;

  AddToWishlistBloc addToWishlistBloc = AddToWishlistBloc();
  DeleteFromWishlistBloc deleteFromWishlistBloc = DeleteFromWishlistBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToWishlistBloc, AddToWishlistState>(
      bloc: addToWishlistBloc,
      listener: (context, state) {
        if (state is AddToWishlistLoadingState) {
          AppToast.normal(AppText.loadingText);
        } else if (state is AddToWishlistSuccessState) {
          AppToast.success(state.message);
        } else if (state is AddToWishlistErrorState) {
          AppToast.danger(state.error);
        }
      },
      child: BlocListener<DeleteFromWishlistBloc, DeleteFromWishlistState>(
        bloc: deleteFromWishlistBloc,
        listener: (context, state) {
          if (state is DeleteFromWishlistLoadingState) {
            AppToast.normal(AppText.loadingText);
          } else if (state is DeleteFromWishlistSuccessState) {
            AppToast.success(state.message);
            context.read<WishlistBloc>().add(
                  WishlistGetDataEvent(
                    page: page,
                    paginateBy: paginateBy,
                  ),
                );
          } else if (state is DeleteFromWishlistErrorState) {
            AppToast.danger(state.error);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: AppColors.appGreyColor,
                ),
                child: GridTile(
                  header: GridTileBar(
                    leading: const SizedBox.shrink(),
                    title: const SizedBox.shrink(),
                    trailing: IconButton(
                      onPressed: () {
                        if (widget.isWishlist == true) {
                          // remove product from wishlist
                          deleteFromWishlistBloc.add(
                            DeleteFromWishlistOnClickEvent(
                              productId: widget.product.id.toString(),
                            ),
                          );
                        } else {
                          // add product to wishlist
                          addToWishlistBloc.add(
                            AddToWishlistOnClickEvent(
                              productId: widget.product.id.toString(),
                            ),
                          );
                        }
                      },
                      icon: CircleAvatar(
                        backgroundColor: AppColors.appWhiteColor,
                        radius: 15,
                        child: Icon(
                          widget.isWishlist == true
                              ? Ionicons.heart
                              : Ionicons.heart_outline,
                          color: widget.isWishlist == true
                              ? AppColors.appRedColor
                              : AppColors.appBlackColor,
                          size: 20,
                          shadows: [
                            Shadow(
                              color: AppColors.appBlackColor,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: ProductsDetailsScreen(
                          productId: widget.product.id!,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle,
                        color: AppColors.appGreyColor,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.product.thumbnail.toString(),
                          ),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: context.width(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.product.name.toString(),
                    style: TextStyle(
                      fontFamily: AppFonts.openSansBold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      AutoSizeText(
                        "\$" + widget.product.unitPrice.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          // delete the text
                          decoration: (widget.product.discount.toDouble() > 0 &&
                                  widget.product.discount != null)
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 5),
                      AutoSizeText(
                        "\$" +
                            Converts.calculateProductPrice(
                                    widget.product.unitPrice.toDouble(),
                                    widget.product.discount.toDouble(),
                                    widget.product.discountType.toString())
                                .toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          // delete the text
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).visible(widget.product.discount.toDouble() > 0 &&
                          widget.product.discount != null),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Ionicons.star,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          AutoSizeText(
                            widget.product.totalRating.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/products/product_details/product_details_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductsDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  final ProductDetailsBloc productDetailsBloc = ProductDetailsBloc();
  int _currentIndex = 0;
  bool readOnly = false;
  @override
  void initState() {
    productDetailsBloc.add(
      ProductDetailsGetDataEvent(productId: widget.productId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      bloc: productDetailsBloc,
      builder: (context, state) {
        if (state is ProductDetailsLoadingState) {
          return Scaffold(body: AppCircularSpinner());
        } else if (state is ProductDetailsSuccessState) {
          return Scaffold(
            appBar: BasicAppbarWidget(title: "Product Details"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: state.products[0].images?.length,
                        options: CarouselOptions(
                          aspectRatio: 1.0,
                          viewportFraction: 1.0,
                          autoPlay: true,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return CachedNetworkImage(
                            imageUrl:
                                state.products[0].images?[index].image ?? "",
                            fit: BoxFit.contain,
                            colorBlendMode: BlendMode.exclusion,
                            errorWidget: (context, url, error) => Icon(
                              Ionicons.image_outline,
                              color: AppColors.appBlackColor,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CarouselIndicator(
                              width: 10,
                              height: 10,
                              count: state.products[0].images?.length,
                              index: _currentIndex,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          state.products[0].name.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: AppFonts.openSansMedium,
                          ),
                        ),
                        10.height,
                        // Rating
                        Row(
                          children: [
                            Icon(
                              Ionicons.star,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            5.width,
                            Text(
                              state.products[0].ratingsCount.toString(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            5.width,
                            Text(
                              "(${state.products[0].ratings!.length} reviews)",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 1),
                        10.height,
                        Text("Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.robotoMonoBold,
                            )),
                        10.height,
                        // display description by default in two lines
                        // but with read more button to show all
                        readOnly
                            ? Text(
                                state.products[0].description.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: AppFonts.openSansRegular,
                                ),
                              )
                            : Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      state.products[0].description.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: AppFonts.openSansRegular,
                                      ),
                                    ),
                                  ),
                                  5.width,
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Read More",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: AppFonts.openSansRegular,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        10.height,
                        Divider(thickness: 1),
                        10.height,
                        Text(
                          "Additional Info",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.robotoMonoBold,
                          ),
                        ),
                        10.height,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: BasicAppbarWidget(title: "Product Details"),
        );
      },
    );
  }
}

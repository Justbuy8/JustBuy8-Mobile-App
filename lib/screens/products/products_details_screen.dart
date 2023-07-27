import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/products/product_details/product_details_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/screens/products/widgets/read_more_button.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quantity_input/quantity_input.dart';

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
  bool readMore = false;
  List<bool> selectedSize = [];
  List<bool> selectedColor = [];
  String size = "";
  String color = "";
  int productQuantity = 1;
  int productPrice = 0;

  @override
  void initState() {
    productDetailsBloc.add(
      ProductDetailsGetDataEvent(productId: widget.productId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
      bloc: productDetailsBloc,
      listener: (context, state) {
        if (state is ProductDetailsSuccessState) {
          // selectedSize = List.generate(
          //   state.product.choiceOptions?[0].options?.length ?? 0,
          //   (index) => false,
          // );

          selectedColor = List.generate(
            state.product.colors?.length ?? 0,
            (index) => false,
          );

          productPrice = state.product.unitPrice.toInt();
        }
      },
      builder: (context, state) {
        if (state is ProductDetailsLoadingState) {
          return Scaffold(body: AppCircularSpinner());
        } else if (state is ProductDetailsSuccessState) {
          return Scaffold(
            appBar: BasicAppbarWidget(title: AppText.productDetailsText),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: state.product.images?.length,
                        options: CarouselOptions(
                          aspectRatio: 1.0,
                          viewportFraction: 1.0,
                          autoPlay: true,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return CachedNetworkImage(
                            imageUrl: state.product.images?[index].image ?? "",
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
                              count: state.product.images?.length,
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
                          state.product.name.toString(),
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
                              state.product.reviewsCount.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.width,
                            Text(
                              "(Reviews})",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 1),
                        10.height,
                        Text(AppText.descriptionText,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.robotoMonoBold,
                            )),
                        // display discription with max 3 lines
                        // and add read more button
                        Html(
                          data: """${state.product.description}""",
                          style: {
                            "body": AppTextStyle.htmlEllipsed,
                          },
                        ),
                        10.height,
                        ReadMoreButton(
                          description: state.product.description.toString(),
                        ),
                        Divider(thickness: 1),
                        10.height,
                        // Text(
                        //   AppText.sizeText,
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontFamily: AppFonts.robotoMonoBold,
                        //   ),
                        // ),
                        // 10.height,
                        // SizedBox(
                        //   height: 60,
                        //   child: ListView.builder(
                        //     itemBuilder: (context, i) => CircleTextButton(
                        //       text: state.product.choiceOptions![0].options![i],
                        //       isSelected: selectedSize[i],
                        //       onPressed: () {
                        //         setState(() {
                        //           size = state
                        //               .product.choiceOptions![0].options![i];
                        //           // make all other is selected false
                        //           for (int j = 0;
                        //               j < selectedSize.length;
                        //               j++) {
                        //             if (j != i) {
                        //               selectedSize[j] = false;
                        //             }
                        //           }
                        //           selectedSize[i] = !selectedSize[i];
                        //         });
                        //       },
                        //     ),
                        //     itemCount:
                        //         state.product.choiceOptions![0].options?.length,
                        //     scrollDirection: Axis.horizontal,
                        //   ),
                        // ),
                        // Divider(thickness: 1),
                        // 10.height,
                        // Display colors if color list is not empty
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppText.colorText,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFonts.robotoMonoBold,
                              ),
                            ),
                            10.height,
                            SizedBox(
                              height: 50.h,
                              child: ListView.builder(
                                itemBuilder: (context, i) => ColorWidget(
                                  colorCode: state.product.colors![i].code!,
                                  isSelected: selectedColor[i],
                                  onPressed: () {
                                    setState(() {
                                      color = state.product.colors![i].name!;
                                      // make all other is selected false
                                      for (int j = 0;
                                          j < selectedColor.length;
                                          j++) {
                                        if (j != i) {
                                          selectedColor[j] = false;
                                        }
                                      }
                                      selectedColor[i] = !selectedColor[i];
                                    });
                                  },
                                ),
                                itemCount: state.product.colors?.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ).visible(state.product.colors?.isNotEmpty ?? false),

                        10.height,
                      ],
                    ),
                  ),
                  Divider(thickness: 3),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppText.priceText,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFonts.robotoMonoBold,
                              ),
                            ),
                            10.width,
                            Text(
                              "\$${productPrice}",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: AppFonts.robotoMonoBold,
                              ),
                            ),
                            Spacer(),
                            QuantityInput(
                              value: productQuantity,
                              onChanged: (p0) {
                                setState(() {
                                  productQuantity = p0.toInt();
                                });
                              },
                              buttonColor: AppColors.backgroundColor,
                              iconColor: AppColors.primaryColor,
                              inputWidth: 50,
                            ),
                          ],
                        ),
                        PrimaryButtonWidget(
                          caption: AppText.addToCartText,
                          onPressed: () {},
                        ),
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

class ColorWidget extends StatelessWidget {
  final String colorCode;
  final bool isSelected;
  final VoidCallback onPressed;

  const ColorWidget(
      {Key? key,
      required this.colorCode,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: CircleAvatar(
          backgroundColor: Color(
              int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000),
          radius: 15,
          child: isSelected
              ? Icon(
                  Ionicons.checkmark,
                  color: AppColors.appWhiteColor,
                )
              : null,
        ),
      ),
    );
  }
}

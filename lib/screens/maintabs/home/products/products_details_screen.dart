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
import 'package:justbuyeight/models/products/ProductDetailsModel.dart';
import 'package:justbuyeight/screens/maintabs/home/products/product_reviews_screen.dart';
import 'package:justbuyeight/screens/maintabs/home/products/widgets/color_widget.dart';
import 'package:justbuyeight/screens/maintabs/home/products/widgets/custom_quantity_input.dart';
import 'package:justbuyeight/screens/maintabs/home/products/widgets/read_more_button.dart';
import 'package:justbuyeight/screens/maintabs/home/products/widgets/rectangular_button_widget.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/shop_details_screen.dart';
import 'package:justbuyeight/utils/AppToast.dart';
import 'package:justbuyeight/utils/Converts.dart';
import 'package:justbuyeight/utils/Navigator.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
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
  /*      Variables     */

  // bloc
  final ProductDetailsBloc productDetailsBloc = ProductDetailsBloc();

  // carousel
  int _currentIndex = 0;

  // product details
  bool readMore = false;
  List<bool> selectedColor = [];
  String selectedOption = '';
  String color = "";
  String variation = "";
  int productQuantity = 1;
  double productPrice = 0.0;
  double totalPrice = 0.0;
  String discountType = '';
  double discount = 0;

  @override
  void initState() {
    productDetailsBloc.add(
      ProductDetailsGetDataEvent(productId: widget.productId),
    );
    super.initState();
  }

  // There is a discount on the product, so we need to calculate the price
  // based on the discount
  calculatePrice(ProductDetailsModel product) {
    setState(() {
      // grab price from product.variation
      // match the variation string with product.variation type

      product.variation?.forEach((_variation) {
        if (_variation.type == variation) {
          productPrice = _variation.price!.toDouble();
          // now calculate the price
          productPrice = Converts.calculateProductPrice(
            productPrice,
            discount,
            discountType,
          );
          totalPrice = productPrice * productQuantity;
        }
      });
    });
  }

  /* 
    There would be one value string which will include all the details 
    like the color of the product, its size, its weight etc.
    So we will concate the value of color, size, weight etc and assign it to
    variation variable.

    Now when user selects the color, we will assign the color value to the
    variation variable and then we will check if the variation variable is
    empty or not, if it is not empty then we will display the options
    like size, weight etc.

    For example:
    If user selects the color, then we will assign the color value to the
    variation variable and then we will check if the variation variable is
    empty or not, if it is not empty then we will display the options
    like size, weight etc.
  */
  handleColor(ProductDetailsModel product, int i) {
    setState(() {
      // reset the selection option
      selectedOption = '';
      // assign value to color...
      color = product.name!;
      // reset the variation....
      variation = color.trim();
      // make all other is selected false
      for (int j = 0; j < selectedColor.length; j++) {
        if (j != i) {
          selectedColor[j] = false;
        }
      }
      selectedColor[i] = !selectedColor[i];

      print(variation);
    });
  }

  @override
  void dispose() {
    productDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
      bloc: productDetailsBloc,
      listener: (context, state) {
        if (state is ProductDetailsSuccessState) {
          selectedColor = List.generate(
            state.product.colors?.length ?? 0,
            (index) => false,
          );

          // select the first color
          selectedColor[0] = true;

          // grab the first color value and assign to variation
          color = state.product.colors?[0].name ?? "";

          // grab out discount and discount type
          discount = state.product.discount.toDouble();
          discountType = state.product.discountType!;
          productPrice = state.product.unitPrice.toDouble();

          // now calculate the price
          productPrice = Converts.calculateProductPrice(
            productPrice,
            discount,
            discountType,
          );

          totalPrice = productPrice;
        }
      },
      builder: (context, state) {
        if (state is ProductDetailsLoadingState) {
          return Scaffold(body: AppCircularSpinner());
        } else if (state is ProductDetailsErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is ProductDetailsSuccessState) {
          return Scaffold(
            appBar: BasicAppbarWidget(title: AppText.productDetailsText),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        "\$${totalPrice}",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.robotoMonoBold,
                        ),
                      ),
                      Spacer(),
                      CustomQuantityInput(
                          value: productQuantity,
                          onChanged: (value, symbol) {
                            setState(() {
                              if (value.toInt() == 0) {
                                productQuantity = 1;
                              }
                              if (symbol == "+") {
                                if (productQuantity >= 1) {
                                  productQuantity = value.toInt();
                                  totalPrice += productPrice;
                                }
                              } else if (symbol == "-") {
                                if (productQuantity > 1) {
                                  productQuantity = value.toInt();
                                  totalPrice -= productPrice;
                                }
                              }
                            });
                          }),
                    ],
                  ),
                  10.height,
                  PrimaryButtonWidget(
                    caption: AppText.addToCartText,
                    onPressed: () {
                      // add to cart
                    },
                  ),
                ],
              ),
            ),
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
                            TextButton(
                              onPressed: () {
                                if (state.product.vendor!.addedBy == 'admin') {
                                  AppToast.normal("This is admin product");
                                } else {
                                  AppNavigator.goToPage(
                                    context: context,
                                    screen: ShopDetailsScreen(
                                      shopId: state.product.vendor!.id.toInt(),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                state.product.vendor!.shopName.toString(),
                                style: AppTextStyle.textButtonStyle,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // go to the reviews screen
                                AppNavigator.goToPage(
                                  context: context,
                                  screen: ProductReviewsScreen(
                                    productId: state.product.id!,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.star,
                                    color: AppColors.primaryColor,
                                    size: 20,
                                  ),
                                  5.width,
                                  Text(
                                    state.product.totalReviews.toString(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  10.width,
                                  Text(
                                    "(${state.product.reviewsCount} Reviews)",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
                          data: "${state.product.description}",
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
                              height: 40.h,
                              child: ListView.builder(
                                itemBuilder: (context, i) => ColorWidget(
                                  colorHexCode: state.product.colors![i].code!,
                                  isSelected: selectedColor[i],
                                  onPressed: () {
                                    handleColor(state.product, i);
                                  },
                                ),
                                itemCount: state.product.colors?.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            10.height,
                            Divider(thickness: 1),
                          ],
                        ).visible(state.product.colors?.isNotEmpty ?? false),
                        10.height,

                        // Now when a user selects color, then we will
                        // display options but only if variation is not empty
                        // and if user selects color

                        Column(
                          children: state.product.choiceOptions!
                              .map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.title!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: AppFonts.robotoMonoBold,
                                        ),
                                      ),
                                      10.height,
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          itemBuilder: (context, i) =>
                                              RectangleButtonWidget(
                                            text: e.options![i],
                                            onPressed: () {
                                              setState(() {
                                                // Assign selected value to the selectedOption variable
                                                variation = color.trim();
                                                selectedOption = e.options![i];
                                                variation =
                                                    "$variation-${selectedOption.trim()}";

                                                calculatePrice(state.product);
                                                print("Variation: $variation");
                                              });
                                            },
                                            selectedOption: selectedOption,
                                          ),
                                          itemCount: e.options?.length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                      10.height,
                                      Divider(thickness: 1),
                                    ],
                                  ))
                              .toList(),
                        ).visible(state.product.choiceOptions!.isNotEmpty &&
                            color.isNotEmpty),

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
          appBar: BasicAppbarWidget(title: AppText.productDetailsText),
        );
      },
    );
  }
}

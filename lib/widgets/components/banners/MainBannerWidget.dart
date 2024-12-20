// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/banners/main_banner_bloc.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/error/retry_error_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class MainBannerWidget extends StatefulWidget {
  const MainBannerWidget({Key? key}) : super(key: key);

  @override
  _MainBannerWidgetState createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  int _currentIndex = 0;
  MainBannerBloc bloc = MainBannerBloc();
  List<String> imageUrls = [];
  List<BannerModel> bannerList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBannerBloc>(
      create: (context) => bloc..add(MainBannerLoadingEvent()),
      child: BlocBuilder<MainBannerBloc, MainBannerState>(
        builder: (context, state) {
          if (state is MainBannerLoadingState) {
            return SizedBox(
              height: context.height() * 0.4,
              child: const AppCircularSpinner(),
            );
          } else if (state is MainBannerDataState) {
            return Stack(
              children: [
                CarouselSlider.builder(
                    itemCount: state.bannerModel.length,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return GestureDetector(
                        onTap: () {
                          if (state.bannerModel[index].resourceType
                                  .toLowerCase() ==
                              "product") {
                            print("product");
                          }
                          if (state.bannerModel[index].resourceType
                                  .toLowerCase() ==
                              "category") {
                            print("category");
                          }
                          if (state.bannerModel[index].resourceType
                                  .toLowerCase() ==
                              "brand") {
                            print("brand");
                          }
                          if (state.bannerModel[index].resourceType
                                  .toLowerCase() ==
                              "shop") {
                            print("shop");
                          }
                        },
                        child: CachedNetworkImage(
                          imageUrl: state.bannerModel[index].imageLink,
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.exclusion,
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColors.appWhiteColor,
                          ),
                        ),
                      );
                    }),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButtonWidget(
                        caption: AppText.shopNow,
                        onPressed: () {},
                        width: context.width() * 0.3,
                      ),
                      CarouselIndicator(
                        width: 10,
                        height: 10,
                        count: state.bannerModel.length,
                        index: _currentIndex,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MainBannerErrorState) {
            return RetryErrorWidget(
              errorMessage: state.message,
            );
          } else {
            return SizedBox(
              height: context.height() * 0.4,
            );
          }
        },
      ),
    );
  }
}

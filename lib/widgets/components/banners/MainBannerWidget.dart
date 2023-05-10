// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/banners/main_banner_block.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
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
      child: BlocConsumer<MainBannerBloc, MainBannerState>(
        listener: (context, state) {
          if (state is MainBannerDataState) {
            bannerList = state.bannerModel;
            for (var element in bannerList) {
              imageUrls.add(element.imageLink.toString());
            }
          }
        },
        builder: (context, state) {
          if (state is MainBannerLoadingState) {
            return SizedBox(
              height: context.height() * 0.4,
              child: const AppCircularSpinner(),
            );
          } else if (state is MainBannerDataState) {
            return Stack(
              children: [
                CarouselSlider(
                  items: imageUrls
                      .map((url) => GestureDetector(
                            onTap: () {
                              if (bannerList[_currentIndex].resourceType ==
                                  "product") {
                                // navigate to product page
                              }
                              if (bannerList[_currentIndex].resourceType ==
                                  "category") {
                                // navigate to category page
                              }
                            },
                            child: Container(
                              height: context.height() * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.fill,
                                colorBlendMode: BlendMode.exclusion,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: AppColors.appWhiteColor,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: context.height() / 3,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButtonWidget(
                        caption: "Shop Now",
                        onPressed: () {},
                        width: context.width() * 0.3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageUrls.map((url) {
                          int index = imageUrls.indexOf(url);
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? AppColors.appWhiteColor
                                  : AppColors.appGreyColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MainBannerErrorState) {
            return SizedBox(
              height: context.height() * 0.4,
              child: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return SizedBox(
              height: context.height() * 0.4,
              child: const Center(
                child: Text("No Data Found"),
              ),
            );
          }
        },
      ),
    );
  }
}

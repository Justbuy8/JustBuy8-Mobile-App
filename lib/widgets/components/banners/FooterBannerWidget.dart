// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/banners/footer_banner_bloc.dart';
import 'package:justbuyeight/blocs/banners/main_banner_block.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';
import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:nb_utils/nb_utils.dart';

class FooterBannerWidget extends StatefulWidget {
  const FooterBannerWidget({Key? key}) : super(key: key);

  @override
  _FooterBannerWidgetState createState() => _FooterBannerWidgetState();
}

class _FooterBannerWidgetState extends State<FooterBannerWidget> {
  int _currentIndex = 0;
  FooterBannerBloc bloc = FooterBannerBloc();
  List<String> imageUrls = [];
  List<BannerModel> bannerList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FooterBannerBloc>(
      create: (context) => bloc..add(FooterBannerLoadingEvent()),
      child: BlocConsumer<FooterBannerBloc, FooterBannerState>(
        listener: (context, state) {
          if (state is FooterBannerDataState) {
            bannerList = state.bannerModel;
            for (var element in bannerList) {
              imageUrls.add(element.imageLink.toString());
            }
          }
        },
        builder: (context, state) {
          if (state is FooterBannerLoadingState) {
            return SizedBox(
              height: context.height() * 0.4,
              child: const AppCircularSpinner(),
            );
          } else if (state is FooterBannerDataState) {
            return Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: state.bannerModel.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              state.bannerModel[index].imageLink.toString(),
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.exclusion,
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColors.appWhiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
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
          } else if (state is FooterBannerErrorState) {
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

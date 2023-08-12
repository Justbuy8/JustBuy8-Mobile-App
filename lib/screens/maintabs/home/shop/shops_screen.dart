import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/shops/get_all_shops/get_all_shops_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/models/shop/Shop.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/widgets/shop_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer_grid_view.dart';
import 'package:lottie/lottie.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int page = AppConfig.PageOne;
  int paginatedBy = AppConfig.GetAllShopsPagenateCount;

  // scroll controller
  ScrollController scrollController = ScrollController();

  // Bloc
  GetAllShopsBloc shopsBloc = GetAllShopsBloc();

  // List
  List<Shop> shops = [];

  @override
  void initState() {
    getInitialShops();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        getMoreShops();
      }
    });
    super.initState();
  }

  getInitialShops() {
    shopsBloc = shopsBloc
      ..add(GetAllShops(page: page, paginatedBy: paginatedBy));
  }

  getMoreShops() {
    shopsBloc = shopsBloc
      ..add(GetMoreShops(page: page, paginatedBy: paginatedBy));
  }

  @override
  void dispose() {
    super.dispose();
    shopsBloc.close();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: AppText.shopsText),
      body: SafeArea(
          child: BlocConsumer<GetAllShopsBloc, GetAllShopsState>(
        bloc: shopsBloc,
        listener: (context, state) {
          if (state is GetAllShopsSuccess) {
            shops.addAll(state.shops);
          }
        },
        builder: (context, state) {
          if (state is GetAllShopsLoading) {
            return RectangularShimmerGridView(
              itemCount: 8,
              childAspectRatio: 1,
            );
          } else if (state is GetAllShopsEmpty) {
            return Center(
              child: Text(
                AppText.noShopsFoundText,
                style: AppTextStyle.heading,
              ),
            );
          } else if (state is GetAllShopsFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // show error lottie
                  Lottie.asset(LottieAssets.error),
                  Text(state.message),
                  ElevatedButton(
                      onPressed: () {
                        getInitialShops();
                      },
                      child: Text(AppText.tryAgain))
                ],
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: shops.length + 2,
            itemBuilder: (context, index) {
              if (index == shops.length || index == shops.length + 1) {
                if (state is GetAllShopsMoreLoading) {
                  return AppCircularSpinner();
                } else
                  return SizedBox.shrink();
              } else
                return ShopWidget(shop: shops[index]);
            },
          );
        },
      )),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/shops/get_all_shops/get_all_shops_bloc.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/screens/maintabs/home/shop/widgets/shop_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class AllShopsGrid extends StatefulWidget {
  const AllShopsGrid({Key? key}) : super(key: key);

  @override
  State<AllShopsGrid> createState() => _AllShopsGridState();
}

class _AllShopsGridState extends State<AllShopsGrid> {
  final int itemCount = 10;
  final int page = AppConfig.PageOne;
  final int paginatedBy = AppConfig.GetAllShopsPagenateCount;

  // bloc
  GetAllShopsBloc getAllShopsBloc = GetAllShopsBloc();

  @override
  void initState() {
    getAllShopsBloc = getAllShopsBloc
      ..add(
        GetAllShops(
          page: page,
          paginatedBy: paginatedBy,
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllShopsBloc, GetAllShopsState>(
      bloc: getAllShopsBloc,
      builder: (context, state) {
        if (state is GetAllShopsLoading) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => RectangularShimmer(),
          );
        } else if (state is GetAllShopsSuccess) {
          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 80),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.shops.length,
                itemBuilder: (context, index) {
                  return ShopWidget(shop: state.shops[index]);
                },
              ),
            ],
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => RectangularShimmer(),
        );
      },
    );
  }
}

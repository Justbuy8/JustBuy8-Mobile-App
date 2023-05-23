// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';


class NewArrivalGrid extends StatefulWidget {
  const NewArrivalGrid({Key? key}) : super(key: key);

  @override
  State<NewArrivalGrid> createState() => _NewArrivalGridState();
}

class _NewArrivalGridState extends State<NewArrivalGrid> {
  double newPrice = 0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewArrivalBloc, NewArrivalState>(
      builder: (context, state) {
        if (state is NewArrivalEmptyState) {
          return NoArrivalsWidget(
            svgImage: LottieAssets.emptyproducts,
            message: state.message,
              width: context.height() /2 ,
             height: context.height() /4,
          );
        }
        if (state is NewArrivalGetAllState) {
          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductWidget(
                   product: state.products[index],
                  );
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

class NoArrivalsWidget extends StatelessWidget {
  const NoArrivalsWidget({
    Key? key,
    required this.message,
    required this.svgImage,
    this.width,
    this.height,
  }) : super(key: key);
  final String message;
  final String svgImage;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          svgImage,
          height: height ?? 100,
          width: width ?? 100,
        ),
        Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

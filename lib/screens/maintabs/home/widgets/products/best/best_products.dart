import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justbuyeight/blocs/products/best/best_products_bloc.dart';
import 'package:justbuyeight/blocs/products/best/best_products_states_and_events.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class BestProducts extends StatelessWidget {
  const BestProducts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BestProductsBloc()
        ..add(
          BestProductsGetAllEvent("1", "10", true),
        ),
      child: BlocBuilder<BestProductsBloc, BestProductsState>(
        builder: (context, state) {
          if (state is BestProductsLoadingState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: const AppCircularSpinner(),
            );
          } else if (state is BestProductsGetAllState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 20,
                ),
                itemCount: state.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BestProduct(
                    imageUrl: state.products[index].thumbnail.toString(),
                  );
                },
              ),
            );
          } else {
            return const RectangularShimmer();
          }
        },
      ),
    );
  }
}

class BestProduct extends StatelessWidget {
  const BestProduct({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() * 0.4,
      // padding: const EdgeInsets.all(8),
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
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: AppColors.appWhiteColor,
              radius: 15,
              child: Icon(
                Ionicons.heart,
                color: AppColors.appRedColor,
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            shape: BoxShape.rectangle,
            color: AppColors.appGreyColor,
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
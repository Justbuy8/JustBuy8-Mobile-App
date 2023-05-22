import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_events_and_states.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class FeaturedProductsListview extends StatelessWidget {
  const FeaturedProductsListview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeaturedProductsBloc>(
      create: (context) => FeaturedProductsBloc()
        ..add(
          FeaturedProductsLoadEvent("1", "5"),
        ),
      child: BlocBuilder<FeaturedProductsBloc, FeaturedProductsState>(
        builder: (context, state) {
          if (state is FeaturedProductsInitState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: const AppCircularSpinner(),
            );
          } else if (state is FeaturedProductsGetState) {
            return SizedBox(
              height: context.height() * 0.35,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    //  create a list of featured products with
                    //  their name and image
                    child: ProductWidget(
                      text: state.products[index].name.toString(),
                      imageUrl: state.products[index].thumbnail.toString(),
                      price: state.products[index].unitPrice.toString(),
                      rating: state.products[index].totalRating.toString(),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_events_and_states.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class FeaturedProductsListview extends StatefulWidget {
  const FeaturedProductsListview({Key? key}) : super(key: key);

  @override
  State<FeaturedProductsListview> createState() =>
      _FeaturedProductsListviewState();
}

class _FeaturedProductsListviewState extends State<FeaturedProductsListview> {
  double newPrice = 0.0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeaturedProductsBloc>(
      create: (context) => FeaturedProductsBloc()
        ..add(
          FeaturedProductsLoadEvent("1", "5", true),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: state.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: state.products[index],
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

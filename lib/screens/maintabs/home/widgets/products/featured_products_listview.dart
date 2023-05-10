import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured_products_bloc.dart';
import 'package:justbuyeight/blocs/products/featured_products_events_and_states.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/featured_products_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';

class FeaturedProductsListview extends StatelessWidget {
  const FeaturedProductsListview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeaturedProductsBloc>(
      create: (context) => FeaturedProductsBloc(),
      child: BlocConsumer<FeaturedProductsBloc, FeaturedProductsState>(
        builder: (context, state) {
          if (state is FeaturedProductsInitState) {
            return const AppCircularSpinner();
          } else if (state is FeaturedProductsGetState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FeaturedProductWidget(
                  text: state.products[index].name.toString(),
                  imageUrl: state.products[index].thumbnail.toString(),
                );
              },
            );
          } else {
            return const Center(child: Text("Error"));
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}

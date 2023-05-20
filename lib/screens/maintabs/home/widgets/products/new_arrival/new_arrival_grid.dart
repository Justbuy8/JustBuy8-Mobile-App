// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class NewArrivalGrid extends StatefulWidget {
  const NewArrivalGrid({Key? key}) : super(key: key);

  @override
  State<NewArrivalGrid> createState() => _NewArrivalGridState();
}

class _NewArrivalGridState extends State<NewArrivalGrid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewArrivalBloc, NewArrivalState>(
      builder: (context, state) {
        if (state is NewArrivalEmptyState) {
          return Center(
            child: Text(state.message),
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
                    text: state.products[index].name.toString(),
                    imageUrl: state.products[index].thumbnail.toString(),
                    price: state.products[index].unitPrice.toString(),
                    rating: state.products[index].totalRating.toString(),
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

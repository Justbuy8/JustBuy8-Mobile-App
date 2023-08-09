import 'package:flutter/material.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class RectangularShimmerGridView extends StatelessWidget {
  final int itemCount;
  const RectangularShimmerGridView({
    Key? key,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return RectangularShimmer();
      },
      padding: const EdgeInsets.all(10.0),
    );
  }
}

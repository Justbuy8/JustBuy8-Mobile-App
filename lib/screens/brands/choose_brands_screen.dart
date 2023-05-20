import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class ChooseBrandsScreen extends StatefulWidget {
  const ChooseBrandsScreen({Key? key}) : super(key: key);

  @override
  State<ChooseBrandsScreen> createState() => _ChooseBrandsScreenState();
}

class _ChooseBrandsScreenState extends State<ChooseBrandsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = 20;
  int page = 1;

  @override
  void initState() {
    BlocProvider.of<BrandsBloc>(context).add(
      BrandsLoadEvent(page.toString(), paginateBy.toString()),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        paginateBy += 20;
        BlocProvider.of<BrandsBloc>(context).add(
          BrandsLoadEvent(page.toString(), paginateBy.toString()),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: "Choose Brands"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<BrandsBloc, BrandsState>(
          builder: (context, state) {
            if (state is BrandsLoadingState) {
              return const AppCircularSpinner();
            }
            if (state is BrandsErrorState) {}
            if (state is BrandsGetState) {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return BrandWidget(
                    text: state.brands[index].brandName.toString(),
                    imageUrl: state.brands[index].brandImage.toString(),
                  );
                },
                itemCount: state.brands.length,
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => const RectangularShimmer(),
              itemCount: 20,
            );
          },
        ),
      ),
    );
  }
}

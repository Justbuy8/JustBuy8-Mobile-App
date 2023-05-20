// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_single_cascade_in_expression_statements, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';
import 'package:justbuyeight/utils/SnackBars.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';

import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';

class ChooseBrandsScreen extends StatefulWidget {
  const ChooseBrandsScreen({Key? key}) : super(key: key);

  @override
  State<ChooseBrandsScreen> createState() => _ChooseBrandsScreenState();
}

class _ChooseBrandsScreenState extends State<ChooseBrandsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = 5;
  int page = 1;

  List<BrandsModel> brands = [];
  var BrandBloc = BrandsBloc();

  @override
  void initState() {
    BrandBloc = BrandsBloc()
      ..add(BrandsLoadEvent(page.toString(), paginateBy.toString()));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        BrandBloc..add(BrandsLoadEvent(page.toString(), paginateBy.toString()));
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
          child: BlocListener(
            bloc: BrandBloc,
            listener: (context, state) {
              if (state is BrandsLoadingState) {}
              if (state is BrandsGetState) {
                setState(() {
                  brands.addAll(state.brands);
                });
              }
              if (state is BrandsEmptyState) {
                SnackBars.Danger(context, state.message);
              }
            },
            child: Expanded(
                child: brands.isEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) =>
                            const RectangularShimmer(),
                        itemCount: 20,
                      )
                    : GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return BrandWidget(
                            text: brands[index].brandName.toString(),
                            imageUrl: brands[index].brandImage.toString(),
                          );
                        },
                        itemCount: brands.length,
                      )),
          )),
    );
  }
}

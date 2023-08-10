// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_single_cascade_in_expression_statements, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/brands/brands_widget.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseBrandsScreen extends StatefulWidget {
  const ChooseBrandsScreen({Key? key}) : super(key: key);

  @override
  State<ChooseBrandsScreen> createState() => _ChooseBrandsScreenState();
}

class _ChooseBrandsScreenState extends State<ChooseBrandsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.HomeBestChooseBrandsPagenateCount;
  int page = AppConfig.PageOne;

  List<BrandsModel> brands = [];
  var brandBloc = BrandsBloc();

  @override
  void initState() {
    brandBloc = BrandsBloc()
      ..add(BrandsLoadEvent(page.toString(), paginateBy.toString(), true));
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        brandBloc
          ..add(BrandsLoadEvent(page.toString(), paginateBy.toString(), false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.chooseBrandsText),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer(
            bloc: brandBloc,
            listener: (context, state) {
              if (state is BrandsGetState) {
                setState(() {
                  brands.addAll(state.brands);
                });
              }
            },
            builder: (context, state) {
              if (state is BrandsErrorState) {
                return Center(
                  child: NoDataWidget(
                    onRetry: () {
                      brandBloc
                        ..add(BrandsLoadEvent(
                            page.toString(), paginateBy.toString(), false));
                    },
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                      child: brands.isEmpty
                          ? GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return const RectangularShimmer();
                              },
                              itemCount: 10,
                            )
                          : GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
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
                ],
              );
            },
          )),
    );
  }
}

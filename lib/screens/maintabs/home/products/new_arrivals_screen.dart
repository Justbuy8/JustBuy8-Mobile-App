import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_images.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/constants/app_textstyle.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
import 'package:justbuyeight/widgets/components/loading_widget/app_circular_spinner.dart';
import 'package:justbuyeight/widgets/components/shimmer/rectangular_shimmer_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class NewArrivalsScreen extends StatefulWidget {
  const NewArrivalsScreen({Key? key}) : super(key: key);

  @override
  State<NewArrivalsScreen> createState() => _NewArrivalsScreenState();
}

class _NewArrivalsScreenState extends State<NewArrivalsScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.HomeBestNewArrivalPagenateCount;
  int page = AppConfig.PageOne;

  List<ProductModel> products = [];
  var bloc = NewArrivalBloc();

  @override
  void initState() {
    super.initState();
    getInitialData();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        getMoreData();
      }
    });
  }

  getInitialData() {
    bloc.add(
      NewArrivalGetInitialData(page.toString(), paginateBy.toString(), "all"),
    );
  }

  getMoreData() {
    bloc.add(
      NewArrivalGetMoreData(page.toString(), paginateBy.toString(), "all"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: AppText.newArrivalsText),
      body: SafeArea(
        child: BlocConsumer<NewArrivalBloc, NewArrivalState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is NewArrivalGetAllState) {
              products.addAll(state.products);
            }
          },
          builder: (context, state) {
            if (state is NewArrivalLoadingState) {
              return RectangularShimmerGridView(itemCount: 8);
            } else if (state is NewArrivalErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      LottieAssets.error,
                      repeat: false,
                    ),
                    10.height,
                    Text(
                      state.message,
                      style: AppTextStyle.heading,
                    ),
                    // retry button
                    20.height,
                    ElevatedButton(
                      onPressed: () {
                        getInitialData();
                      },
                      child: Text(AppText.tryAgain),
                    ),
                  ],
                ),
              );
            } else if (state is NewArrivalEmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      LottieAssets.emptyproducts,
                      repeat: false,
                    ),
                    10.height,
                    Text(
                      state.message,
                      style: AppTextStyle.heading,
                    ),
                  ],
                ),
              );
            }
            return products.isEmpty
                ? NoDataWidget()
                : GridView.builder(
                    controller: _scrollController,
                    itemCount: products.length + 2,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      if (index == products.length ||
                          index == products.length + 1) {
                        if (state is NewArrivalLoadingMoreState) {
                          return const AppCircularSpinner();
                        } else
                          return const SizedBox.shrink();
                      } else
                        return ProductWidget(product: products[index]);
                    },
                    padding: const EdgeInsets.all(10.0),
                  );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_config.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:justbuyeight/screens/maintabs/home/widgets/products/product_widget.dart';
import 'package:justbuyeight/widgets/components/appbars/basic_appbar_widget.dart';
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
    bloc = bloc
      ..add(
        NewArrivalGetAllEvent(page.toString(), paginateBy.toString(), "all"),
      );
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.LoadOnScrollHeight) {
        page++;
        bloc.add(
          NewArrivalGetAllEvent(page.toString(), paginateBy.toString(), "all"),
        );
      }
    });
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
          return products.isEmpty
              ? NoDataWidget()
              : GridView.builder(
                  controller: _scrollController,
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return ProductWidget(product: products[index]);
                  },
                  padding: const EdgeInsets.all(10.0),
                );
        },
      )),
    );
  }
}

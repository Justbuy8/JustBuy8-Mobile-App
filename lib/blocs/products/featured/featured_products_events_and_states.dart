// events

import 'package:justbuyeight/models/products/ProductModel.dart';

abstract class FeaturedProductsEvent {}

class FeaturedProductsLoadEvent extends FeaturedProductsEvent {
  final String page;
  final String paginateBy;
  final bool random;
  FeaturedProductsLoadEvent(this.page, this.paginateBy, this.random);
}

//states
abstract class FeaturedProductsState {}

class FeaturedProductsInitState extends FeaturedProductsState {}

class FeaturedProductsGetState extends FeaturedProductsState {
  final List<ProductModel> products;
  FeaturedProductsGetState(this.products);
}

class FeaturedProductsErrorState extends FeaturedProductsState {
  final String message;
  FeaturedProductsErrorState(this.message);
}

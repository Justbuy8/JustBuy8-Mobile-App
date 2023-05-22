// events

import 'package:justbuyeight/models/products/ProductModel.dart';

abstract class BestProductsEvent {}

class BestProductsGetAllEvent extends BestProductsEvent {
  final String page;
  final String paginateBy;
  final String categoryId;

  BestProductsGetAllEvent(
    this.page,
    this.paginateBy,
    this.categoryId,
  );
}

//states
abstract class BestProductsState {}

class BestProductsLoadingState extends BestProductsState {}

class BestProductsEmptyState extends BestProductsState {
  final String message;
  BestProductsEmptyState({this.message = "No Arrivals found"});
}

class BestProductsGetAllState extends BestProductsState {
  final List<ProductModel> products;
  BestProductsGetAllState(this.products);
}

class BestProductsErrorState extends BestProductsState {
  final String message;
  BestProductsErrorState(this.message);
}

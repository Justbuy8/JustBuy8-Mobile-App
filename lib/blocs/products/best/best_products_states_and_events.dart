// events

import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

abstract class BestProductsEvent {}

class BestProductsGetAllEvent extends BestProductsEvent {
  final String page;
  final String paginateBy;
  final bool random;

  BestProductsGetAllEvent(
    this.page,
    this.paginateBy,
    this.random,
  );
}

//states
abstract class BestProductsState {}

class BestProductsLoadingState extends BestProductsState {}

class BestProductsEmptyState extends BestProductsState {
  final String message;
  BestProductsEmptyState({this.message = AppText.noProductsFound});
}

class BestProductsGetAllState extends BestProductsState {
  final List<ProductModel> products;
  BestProductsGetAllState(this.products);
}

class BestProductsErrorState extends BestProductsState {
  final String message;
  BestProductsErrorState(this.message);
}

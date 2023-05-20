// events

import 'package:justbuyeight/models/products/ProductModel.dart';

abstract class NewArrivalEvent {}

class NewArrivalGetAllEvent extends NewArrivalEvent {
  final String page;
  final String paginateBy;
  final String categoryId;

  NewArrivalGetAllEvent(
    this.page,
    this.paginateBy,
    this.categoryId,
  );
}

//states
abstract class NewArrivalState {}

class NewArrivalLoadingState extends NewArrivalState {}

class NewArrivalEmptyState extends NewArrivalState {
  final String message;
  NewArrivalEmptyState({this.message = "No Arrivals found"});
}

class NewArrivalGetAllState extends NewArrivalState {
  final List<ProductModel> products;
  NewArrivalGetAllState(this.products);
}

class NewArrivalErrorState extends NewArrivalState {
  final String message;
  NewArrivalErrorState(this.message);
}

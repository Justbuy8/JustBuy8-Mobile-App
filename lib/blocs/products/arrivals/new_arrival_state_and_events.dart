// events

import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

abstract class NewArrivalEvent {}

class NewArrivalGetInitialData extends NewArrivalEvent {
  final String page;
  final String paginateBy;
  final String categoryId;

  NewArrivalGetInitialData(
    this.page,
    this.paginateBy,
    this.categoryId,
  );
}

class NewArrivalGetMoreData extends NewArrivalEvent {
  final String page;
  final String paginateBy;
  final String categoryId;

  NewArrivalGetMoreData(
    this.page,
    this.paginateBy,
    this.categoryId,
  );
}

//states
abstract class NewArrivalState {}

class NewArrivalLoadingState extends NewArrivalState {}

class NewArrivalLoadingMoreState extends NewArrivalState {}

class NewArrivalEmptyState extends NewArrivalState {
  final String message;
  NewArrivalEmptyState({this.message = AppText.noArrivalsFound});
}

class NewArrivalGetAllState extends NewArrivalState {
  final List<ProductModel> products;
  NewArrivalGetAllState(this.products);
}

class NewArrivalErrorState extends NewArrivalState {
  final String message;
  NewArrivalErrorState(this.message);
}

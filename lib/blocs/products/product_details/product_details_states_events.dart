part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent {}

class ProductDetailsGetDataEvent extends ProductDetailsEvent {
  final int productId;
  ProductDetailsGetDataEvent({required this.productId});
}

// States
abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsSuccessState extends ProductDetailsState {
  final ProductDetailsModel product;
  ProductDetailsSuccessState({required this.product});
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String error;
  ProductDetailsErrorState({required this.error});
}

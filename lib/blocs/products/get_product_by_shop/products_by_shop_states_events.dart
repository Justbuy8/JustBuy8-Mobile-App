part of 'products_by_shop_bloc.dart';

// Events
abstract class ProductsByShopEvent {}

class GetProductsByShopInitial extends ProductsByShopEvent {
  int page, paginateBy;
  final int shopId;
  GetProductsByShopInitial({
    required this.shopId,
    required this.page,
    required this.paginateBy,
  });
}

class GetProductsByShopMore extends ProductsByShopEvent {
  final int shopId, page, paginateBy;

  GetProductsByShopMore({
    required this.shopId,
    required this.page,
    required this.paginateBy,
  });
}

// States
abstract class ProductsByShopState {}

class ProductsByShopInitial extends ProductsByShopState {}

class ProductsByShopLoading extends ProductsByShopState {}

class ProductsByShopMoreLoading extends ProductsByShopState {}

class ProductsByShopLoaded extends ProductsByShopState {
  final List<ProductModel> products;
  ProductsByShopLoaded({required this.products});
}

class ProductsByShopEmpty extends ProductsByShopState {}

class ProductsByShopFailed extends ProductsByShopState {
  final String message;
  ProductsByShopFailed({required this.message});
}

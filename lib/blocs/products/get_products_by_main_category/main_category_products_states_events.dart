part of 'main_category_products_bloc.dart';

// events

abstract class MainCategoryProductsEvent {}

class MainCategoryProductsLoadEvent extends MainCategoryProductsEvent {
  final String page;
  final String paginateBy;
  final int categoryId;
  MainCategoryProductsLoadEvent(this.page, this.paginateBy, this.categoryId);
}

//states
abstract class MainCategoryProductsState {}

class MainCategoryProductsInitState extends MainCategoryProductsState {}

class MainCategoryProductsGetState extends MainCategoryProductsState {
  final List<ProductModel> products;
  MainCategoryProductsGetState(this.products);
}

class MainCategoryProductsErrorState extends MainCategoryProductsState {
  final String message;
  MainCategoryProductsErrorState(this.message);
}

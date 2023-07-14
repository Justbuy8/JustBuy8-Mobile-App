part of 'child_category_products_bloc.dart';

// Events

abstract class ChildCategoryProductsEvent {}

class ChildCategoryProductsLoadEvent extends ChildCategoryProductsEvent {
  final String page;
  final String paginateBy;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  ChildCategoryProductsLoadEvent(
    this.page,
    this.paginateBy,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
  );
}

//states
abstract class ChildCategoryProductsState {}

class ChildCategoryProductsInitState extends ChildCategoryProductsState {}

class ChildCategoryProductsGetState extends ChildCategoryProductsState {
  final List<ProductModel> products;
  ChildCategoryProductsGetState(this.products);
}

class ChildCategoryProductsErrorState extends ChildCategoryProductsState {
  final String message;
  ChildCategoryProductsErrorState(this.message);
}

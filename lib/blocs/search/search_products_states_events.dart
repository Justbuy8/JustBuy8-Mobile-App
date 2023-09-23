part of 'search_products_bloc.dart';

// Events

abstract class SearchProductsEvent {}

class SearchProductsOnSearchEvent extends SearchProductsEvent {
  final String searchQuery, page, paginatedBy;
  final String? method, category;
  final num? startingPrice, endingPrice;
  final String? totalRatings;

  SearchProductsOnSearchEvent({
    required this.searchQuery,
    required this.page,
    required this.paginatedBy,
    this.method,
    this.category,
    this.startingPrice,
    this.endingPrice,
    this.totalRatings,
  });
}

class SearchedProductsMoreDataEvent extends SearchProductsEvent {
  final String searchQuery, page, paginatedBy;
  final String? method, category;
  final num? startingPrice, endingPrice;
  final String? totalRatings;

  SearchedProductsMoreDataEvent({
    required this.searchQuery,
    required this.page,
    required this.paginatedBy,
    this.method,
    this.category,
    this.startingPrice,
    this.endingPrice,
    this.totalRatings,
  });
}

// States
abstract class SearchProductsState {}

class SearchProductsInitialState extends SearchProductsState {}

class SearchProductsLoadingState extends SearchProductsState {}

class SearchProductsLoadingMoreState extends SearchProductsState {}

class SearchProductsDataState extends SearchProductsState {
  final List<ProductModel> products;

  SearchProductsDataState({required this.products});
}

class SearchProductsErrorState extends SearchProductsState {
  final String error;

  SearchProductsErrorState({required this.error});
}

class SearchProductsEmptyState extends SearchProductsState {}

part of 'search_products_bloc.dart';

// Events

abstract class SearchProductsEvent {}

class SearchProductsOnSearchEvent extends SearchProductsEvent {
  final String searchQuery;

  SearchProductsOnSearchEvent({required this.searchQuery});
}

// States
abstract class SearchProductsState {}

class SearchProductsInitialState extends SearchProductsState {}

class SearchProductsLoadingState extends SearchProductsState {}

class SearchProductsDataState extends SearchProductsState {
  final List<ProductModel> products;

  SearchProductsDataState({required this.products});
}

class SearchProductsErrorState extends SearchProductsState {
  final String error;

  SearchProductsErrorState({required this.error});
}

class SearchProductsEmptyState extends SearchProductsState {}

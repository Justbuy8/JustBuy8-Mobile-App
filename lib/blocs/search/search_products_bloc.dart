import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/search/search_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'search_products_states_events.dart';

class SearchProductsBloc
    extends Bloc<SearchProductsEvent, SearchProductsState> {
  SearchProductsBloc() : super(SearchProductsInitialState()) {
    List<ProductModel> products = [];

    // Event Handling
    on<SearchProductsOnSearchEvent>((event, emit) async {
      emit(SearchProductsLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(SearchProductsErrorState(error: "No Internet Connection"));
        } else {
          // business logic
          products = await SearchProductsController.getProducts(
            event.searchQuery,
            event.page,
            event.paginatedBy,
            category: event.category,
            method: event.method,
            startingPrice: event.startingPrice,
            endingPrice: event.endingPrice,
            totalRatings: event.totalRatings,
          );
          if (products.isNotEmpty) {
            emit(SearchProductsDataState(products: products));
          } else {
            emit(SearchProductsEmptyState());
          }
        }
      } catch (error) {
        emit(SearchProductsErrorState(error: error.toString()));
      }
    });

    // Get more searched products
    on<SearchedProductsMoreDataEvent>((event, emit) async {
      emit(SearchProductsLoadingMoreState());
      try {
        products = await SearchProductsController.getProducts(
          event.searchQuery,
          event.page,
          event.paginatedBy,
          category: event.category,
          method: event.method,
          startingPrice: event.startingPrice,
          endingPrice: event.endingPrice,
          totalRatings: event.totalRatings,
        );
        emit(SearchProductsDataState(products: products));
      } catch (_) {}
    });
  }
}

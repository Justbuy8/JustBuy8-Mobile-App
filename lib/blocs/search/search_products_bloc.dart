// Import necessary libraries and files
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/search/search_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

// Import the events and states for the SearchProductsBloc
part 'search_products_states_events.dart';

// Create a BLoC class for managing the search products
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
          // Perform the search operation using the provided search parameters
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
            // Emit data state with the search results
            emit(SearchProductsDataState(products: products));
          } else {
            // Emit empty state if no results were found
            emit(SearchProductsEmptyState());
          }
        }
      } catch (error) {
        // Handle errors, such as network issues or API errors
        emit(SearchProductsErrorState(error: error.toString()));
      }
    });

    // Get more searched products
    on<SearchedProductsMoreDataEvent>((event, emit) async {
      emit(SearchProductsLoadingMoreState());
      try {
        // Perform a search for more products using the provided parameters
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

        // Emit data state with the additional search results
        emit(SearchProductsDataState(products: products));
      } catch (_) {
        // Handle errors if necessary
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/search/search_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'search_products_states_events.dart';

class SearchProductsBloc
    extends Bloc<SearchProductsEvent, SearchProductsState> {
  SearchProductsBloc() : super(SearchProductsInitialState()) {
    // Event Handling
    on<SearchProductsOnSearchEvent>((event, emit) async {
      List<ProductModel> products = [];
      emit(SearchProductsLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(SearchProductsErrorState(error: "No Internet Connection"));
        } else {
          // business logic
          products =
              await SearchProductsController.getProducts(event.searchQuery);
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
  }
}

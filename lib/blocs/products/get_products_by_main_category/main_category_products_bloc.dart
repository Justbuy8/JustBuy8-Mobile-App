import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/main_category_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Define a Bloc class for managing the state of main category products.
part 'main_category_products_states_events.dart';

class MainCategoryProductsBloc
    extends Bloc<MainCategoryProductsEvent, MainCategoryProductsState> {
  MainCategoryProductsBloc() : super(MainCategoryProductsInitState()) {
    List<ProductModel> products = [];

    // Handle the event to load main category products.
    on<MainCategoryProductsLoadEvent>((event, emit) async {
      // Emit an initial state to indicate that data is being fetched.
      emit(MainCategoryProductsInitState());
      try {
        // Fetch products from the main category using the controller.
        products = await MainCategoryProductsController.getProducts(
            event.page, event.paginateBy, event.categoryId);

        // Emit a state with the fetched products.
        emit(MainCategoryProductsGetState(products));
      } catch (e) {
        // Handle different types of exceptions and emit an appropriate error state.
        if (e is SocketException) {
          emit(MainCategoryProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(MainCategoryProductsErrorState(AppText.serverError));
        } else {
          emit(MainCategoryProductsErrorState(e.toString()));
        }
      }
    });
  }
}

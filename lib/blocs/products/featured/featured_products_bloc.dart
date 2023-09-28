import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_events_and_states.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/featured_products_controller.dart';

// Define a Bloc class for managing the state of featured products.
class FeaturedProductsBloc
    extends Bloc<FeaturedProductsEvent, FeaturedProductsState> {
  FeaturedProductsBloc() : super(FeaturedProductsInitState()) {
    on<FeaturedProductsLoadEvent>((event, emit) async {
      // Emit the initial state to indicate that data is being fetched.
      emit(FeaturedProductsInitState());
      try {
        // Fetch featured products using the controller.
        final products = await FeaturedProductsController.getFeaturedProducts(
            event.page, event.paginateBy, event.random);
        // Emit the state with the fetched products.
        emit(FeaturedProductsGetState(products));
      } catch (e) {
        // Handle potential exceptions (error handling).
        if (e is SocketException) {
          // Emit an error state with an internet connectivity message.
          emit(FeaturedProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          // Emit an error state with a server error message.
          emit(FeaturedProductsErrorState(AppText.serverError));
        } else {
          // Emit an error state with a generic error message.
          emit(FeaturedProductsErrorState(e.toString()));
        }
      }
    });
  }
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/best/best_products_states_and_events.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/best_products_controller.dart';

// Define a Bloc class for managing the state of best products.
class BestProductsBloc extends Bloc<BestProductsEvent, BestProductsState> {
  BestProductsBloc() : super(BestProductsLoadingState()) {
    on<BestProductsGetInitData>((event, emit) async {
      // Emit the loading state to indicate that data is being fetched.
      emit(BestProductsLoadingState());
      try {
        // Fetch best products using the controller.
        final products = await BestProductsController.getBestProducts(
          event.page,
          event.paginateBy,
          event.random,
        );

        // Check if the fetched products list is empty.
        if (products.isEmpty) {
          // If empty, emit the state to indicate no data is available.
          emit(BestProductsEmptyState());
        } else {
          // If data is available, emit the state with the fetched products.
          emit(BestProductsGetAllState(products));
        }
      } catch (e) {
        // Handle potential exceptions, such as network errors.
        if (e is SocketException) {
          // Emit an error state with an internet connectivity message.
          emit(BestProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          // Emit an error state with a server error message.
          emit(BestProductsErrorState(AppText.serverError));
        } else {
          // Emit an error state with a generic error message.
          emit(BestProductsErrorState(e.toString()));
        }
      }
    });

    // Get more data
    on<BestProductsGetMoreData>((event, emit) async {
      // Emit the loading state to indicate that more data is being fetched.
      emit(BestProductsLoadingMoreState());
      try {
        // Fetch more best products using the controller.
        final products = await BestProductsController.getBestProducts(
          event.page,
          event.paginateBy,
          event.random,
        );

        // Emit the state with the updated products data.
        emit(BestProductsGetAllState(products));
      } catch (e) {
        // Handle potential exceptions (error handling).
        // Note: Error handling can be added here if needed.
      }
    });
  }
}

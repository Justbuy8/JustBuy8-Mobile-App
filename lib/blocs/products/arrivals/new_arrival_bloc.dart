import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/new_arrival_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Define a Bloc class for managing the state of new arrival products.
class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  NewArrivalBloc() : super(NewArrivalInitState()) {
    List<ProductModel> products = [];

    // Event Handling
    // Handle the event to fetch initial data for new arrival products.
    on<NewArrivalGetInitialData>((event, emit) async {
      // Set the loading state to inform the UI that data is being fetched.
      emit(NewArrivalLoadingState());
      try {
        // Fetch new arrival products using the controller.
        products = await NewArrivalController.getNewArrivals(
          event.page,
          event.paginateBy,
          event.categoryId,
        );

        // Check if the fetched data is empty.
        if (products.isEmpty) {
          // If empty, set the state to indicate no data is available.
          emit(NewArrivalEmptyState());
          return;
        }

        // If data is available, set the state to provide the fetched products.
        emit(NewArrivalGetAllState(products));
      } catch (e) {
        // Handle potential exceptions, such as network errors.
        if (e is SocketException) {
          // Set the error state with an internet connectivity message.
          emit(NewArrivalErrorState(AppText.internetError));
        } else if (e is HttpException) {
          // Set the error state with a server error message.
          emit(NewArrivalErrorState(AppText.serverError));
        } else {
          // Set the error state with a generic error message.
          emit(NewArrivalErrorState(e.toString()));
        }
      }
    });

    // Get more data
    // Handle the event to fetch more data for new arrival products (pagination).
    on<NewArrivalGetMoreData>((event, emit) async {
      // Set the loading state to inform the UI that more data is being fetched.
      emit(NewArrivalLoadingMoreState());
      try {
        // Fetch more new arrival products using the controller.
        products = await NewArrivalController.getNewArrivals(
          event.page,
          event.paginateBy,
          event.categoryId,
        );

        // Set the state to provide the updated products data.
        emit(NewArrivalGetAllState(products));
      } catch (e) {
        // Handle potential exceptions (error handling).
        // Note: Error handling can be added here if needed.
      }
    });
  }
}

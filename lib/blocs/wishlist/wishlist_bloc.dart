// Import necessary libraries and files
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/wishlist/wishlist_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Import the events and states for the WishlistBloc
part 'wishlist_states_events.dart';

// Create a BLoC class for managing the wishlist
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitState()) {
    List<ProductModel> products = [];

    // Event Handling
    on<WishlistGetInitialData>((event, emit) async {
      emit(WishlistLoadingState());
      try {
        // Get initial wishlist data
        products = await WishlistController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
        );

        if (products.isEmpty) {
          // Emit an empty state if no products are in the wishlist
          emit(WishlistEmptyState());
        } else {
          // Emit data state with the wishlist products
          emit(WishlistGetState(products));
        }
      } catch (e) {
        // Handle errors, such as internet connection issues, server errors, or others
        if (e is SocketException) {
          emit(WishlistErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(WishlistErrorState(AppText.serverError));
        } else {
          emit(WishlistErrorState(e.toString()));
        }
      }
    });

    // Get more wishlist data
    on<WishlistGetMoreData>((event, emit) async {
      emit(WishlistLoadingMoreState());
      try {
        // Get more wishlist data
        products = await WishlistController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
        );

        // Emit data state with the additional wishlist products
        emit(WishlistGetState(products));
      } catch (e) {
        // Handle errors if necessary
        // (Note: The error handling is currently commented out in your code)
      }
    });
  }
}

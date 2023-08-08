import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/wishlist/wishlist_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

part 'wishlist_states_events.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitState()) {
    List<ProductModel> products = [];

    on<WishlistGetInitialData>((event, emit) async {
      emit(WishlistLoadingState());
      try {
        products = await WishlistController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
        );
        if (products.isEmpty) {
          emit(WishlistEmptyState());
        } else {
          emit(WishlistGetState(products));
        }
      } catch (e) {
        if (e is SocketException) {
          emit(WishlistErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(WishlistErrorState(AppText.serverError));
        } else {
          emit(WishlistErrorState(e.toString()));
        }
      }
    });

    // Get more data
    on<WishlistGetMoreData>((event, emit) async {
      emit(WishlistLoadingMoreState());
      try {
        products = await WishlistController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
        );

        emit(WishlistGetState(products));
      } catch (e) {
        // if (e is SocketException) {
        //   emit(WishlistErrorState(AppText.internetError));
        // } else if (e is HttpException) {
        //   emit(WishlistErrorState(AppText.serverError));
        // } else {
        //   emit(WishlistErrorState(e.toString()));
        // }
      }
    });
  }
}

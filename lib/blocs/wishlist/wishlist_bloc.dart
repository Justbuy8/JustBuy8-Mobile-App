import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/wishlist/wishlist_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

part 'wishlist_states_events.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitState()) {
    List<ProductModel> products = [];
    on<WishlistGetDataEvent>((event, emit) async {
      emit(WishlistInitState());
      try {
        products = await WishlistController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
        );
        emit(WishlistGetState(products));
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
  }
}

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/cart/cart_controller.dart';
import 'package:justbuyeight/models/cart/get_cart_model.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(GetCartInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;
  List<GetCartModel> listModel = [];

  getCart() async {
    emit(GetCartLoading(cartData: listModel));
    try {
      response = await CartController.getCart();

      if (response['Success'] == true && response['Message'] == 'Cart Found') {
        var decodedList = GetCartModel.fromJson(response);
        listModel = [decodedList];
        emit(GetCartLoaded(cartData: [decodedList]));
      } else if (response['Success'] == false &&
          response['Message'] == 'Cart not Found.') {
        listModel = [];
        emit(GetNoCartFound());
      }
    } on SocketException {
      emit(GetCartInternetError());
    } on TimeoutException {
      emit(GetCartTimeout());
    } catch (e) {
      emit(GetCartFailed());
    }
  }

  incrementinQuantity(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      response = await CartController.incrementInQuantity(mapBody);

      if (response['Success'] == true &&
          response['Message'] == 'Quantity increased') {
        emit(GetCartQuantityIncreases());
      } else {
        emit(GetCartQuantityIncreasesFailed(response['Message']));
      }
    } catch (e) {
      emit(GetCartQuantityIncreasesFailed(response['Message']));
    }
  }

  decrementinQuantity(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      response = await CartController.decrementInQuantity(mapBody);

      if (response['Success'] == true &&
          response['Message'] == 'Quantity decreased') {
        emit(GetCartQuantityDecreases());
      } else {
        emit(GetCartQuantityDecreasesFailed(response['Message']));
      }
    } catch (e) {
      emit(GetCartQuantityDecreasesFailed(response['Message']));
    }
  }

  deleteCartItem(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      response = await CartController.deleteCart(mapBody);

      if (response['Success'] == true &&
          response['Message'] == 'Remove from Cart') {
        emit(GetCartDeleted());
      }
    } catch (e) {
      emit(GetCartQuantityDecreases());
    }
  }
}

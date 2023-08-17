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

  getCart() async {
    emit(GetCartLoading());
    try {
      response = await CartController.getCart();

      if (response['Success'] == true && response['Message'] == 'Cart Found') {
        var decodedList = GetCartModel.fromJson(response);

        emit(GetCartLoaded(cartData: [decodedList]));
      } else if (response['Success'] == false &&
          response['Message'] == 'Cart not Found.') {
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
}
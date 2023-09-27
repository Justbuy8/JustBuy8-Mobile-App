import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/cart/cart_controller.dart';
import 'package:justbuyeight/models/cart/get_cart_model.dart';
import 'package:justbuyeight/models/coupons/coupons_model.dart' as coupons;

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  // Constructor for the GetCartCubit class.
  GetCartCubit() : super(GetCartInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // List to store cart data models.
  List<GetCartModel> listModel = [];

  // Variable to store coupon data.
  coupons.Datum? couponsData;

  // Method to fetch cart data.
  getCart() async {
    // Emit a loading state with the current cart data.
    emit(GetCartLoading(cartData: listModel));
    try {
      // Call the getCart method from the CartController.
      response = await CartController.getCart();

      // Check the response for different scenarios.
      if (response['Success'] == true && response['Message'] == 'Cart Found') {
        // Parse the response into a GetCartModel and update the listModel.
        var decodedList = GetCartModel.fromJson(response);
        listModel = [decodedList];
        emit(GetCartLoaded(cartData: [decodedList]));
      } else if (response['Success'] == false &&
          response['Message'] == 'Cart not Found.') {
        // If the cart is not found, clear the listModel and emit a no cart found state.
        listModel = [];
        emit(GetNoCartFound());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(GetCartInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(GetCartTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(GetCartFailed());
    }
  }

  // Method to increment the quantity of an item in the cart.
  incrementinQuantity(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      // Call the incrementInQuantity method from the CartController.
      response = await CartController.incrementInQuantity(mapBody);

      // Check the response for success or failure.
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

  // Method to decrement the quantity of an item in the cart.
  decrementinQuantity(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      // Call the decrementInQuantity method from the CartController.
      response = await CartController.decrementInQuantity(mapBody);

      // Check the response for success or failure.
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

  // Method to delete an item from the cart.
  deleteCartItem(cartId) async {
    emit(GetCartLoading(cartData: listModel));
    try {
      var mapBody = {"cart_id": cartId};
      // Call the deleteCart method from the CartController.
      response = await CartController.deleteCart(mapBody);

      // Check the response for success or failure.
      if (response['Success'] == true &&
          response['Message'] == 'Remove from Cart') {
        emit(GetCartDeleted());
      }
    } catch (e) {
      emit(GetCartQuantityDecreases());
    }
  }

  // Method to store selected coupon information.
  getCouponsInformation(data) {
    couponsData = data;
    emit(GetCartCouponSelected());
  }
}

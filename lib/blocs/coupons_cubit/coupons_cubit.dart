import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/coupons/coupons_controller.dart';
import 'package:justbuyeight/models/coupons/coupons_model.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  // Constructor for the CouponsCubit class.
  CouponsCubit() : super(CouponsInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to fetch coupons data.
  getCoupons() async {
    // Emit a loading state to indicate that coupon data is being fetched.
    emit(CouponsLoading());
    try {
      // Call the getCoupons method from the CouponsController.
      response = await CouponsController.getCoupons();
      print(response); // Print the response for debugging purposes.

      // Check the response for different scenarios.
      if (response['Success'] == true &&
          response['Message'] == 'Coupons Found') {
        // Parse the response into a GetCouponsModel and emit the loaded state.
        var decodedList = GetCouponsModel.fromJson(response);
        emit(CouponsLoaded(couponsData: [decodedList]));
      } else if (response['Success'] == true &&
          response['Message'] == 'No Coupons Found') {
        // If no coupons are found, emit a state indicating that.
        emit(GetNoCouponsFound());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(CouponsInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(CouponsTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(CouponsFailed());
    }
  }
}

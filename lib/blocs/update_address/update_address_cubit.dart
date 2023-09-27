// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  // Constructor for the UpdateAddressCubit class.
  UpdateAddressCubit() : super(UpdateAddressInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to update a user's address.
  updateAddress(body) async {
    // Emit a loading state to indicate that address update is in progress.
    emit(UpdateAddressLoading());
    try {
      // Call the updateAddress method from the AddressController.
      response = await AddressController.updateAddress(body);

      // Check the response for success.
      if (response['Message'] == 'Address Updated.' &&
          response['Success'] == true) {
        // If the address update was successful, emit a success state.
        emit(UpdateAddressSuccessfull());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(UpdateAddressInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(UpdateAddressTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(UpdateAddressFailed());
    }
  }
}

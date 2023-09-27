// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';
import 'package:justbuyeight/models/myaddress/my_address_model.dart';

part 'get_address_state.dart';

// Define a class named GetAddressCubit that extends the Cubit class
// with the generic type GetAddressState.
class GetAddressCubit extends Cubit<GetAddressState> {
  // Constructor for the GetAddressCubit class.
  // It initializes the cubit with the GetAddressInitial state.
  GetAddressCubit() : super(GetAddressInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare a dynamic variable named response.
  dynamic response;

  // Define an asynchronous function named getAddress.
  getAddress() async {
    // Emit the GetAddressLoading state to indicate that an operation is in progress.
    emit(GetAddressLoading());

    try {
      // Call the getAddress method from the AddressController class
      // and assign the result to the 'response' variable.
      response = await AddressController.getAddress();

      // Check if the response contains a 'Success' key with the value 'true'
      // and a 'Message' key with the value 'Addresses Found.'
      if (response['Success'] == true &&
          response['Message'] == 'Addresses Found.') {
        // Decode the response into an AddressModel and emit the GetAddressLoaded state
        // with the decoded data as a list in 'addressData'.
        var decodedList = AddressModel.fromJson(response);
        emit(GetAddressLoaded(addressData: [decodedList]));
      } else if (response['Success'] == true &&
          response['Message'] == 'No Saved Addresses Found') {
        // If 'Success' is true but 'Message' is 'No Saved Addresses Found',
        // emit the GetNoAddressFound state to indicate that no addresses were found.
        emit(GetNoAddressFound());
      }
    } on SocketException {
      // If a SocketException is caught, emit the GetAddressInternetError state
      // to handle network-related errors.
      emit(GetAddressInternetError());
    } on TimeoutException {
      // If a TimeoutException is caught, emit the GetAddressTimeout state
      // to handle timeout errors.
      emit(GetAddressTimeout());
    } catch (e) {
      // If any other exception is caught, emit the GetAddressFailed state
      // to indicate a general failure.
      emit(GetAddressFailed());
    }
  }
}

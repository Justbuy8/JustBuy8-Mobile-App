// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';

part 'create_address_state.dart';

// Define a class named CreateAddressCubit that extends the Cubit class
// with the generic type CreateAddressState.
class CreateAddressCubit extends Cubit<CreateAddressState> {
  // Constructor for the CreateAddressCubit class.
  // It initializes the cubit with the CreateAddressInitial state.
  CreateAddressCubit() : super(CreateAddressInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare a dynamic variable named response.
  dynamic response;

  // Define an asynchronous function named createNewAddress that takes a 'body' parameter.
  createNewAddress(body) async {
    // Emit the CreateAddressLoading state to indicate that an operation is in progress.
    emit(CreateAddressLoading());

    try {
      // Call the createAddress method from the AddressController class
      // and assign the result to the 'response' variable.
      response = await AddressController.createAddress(body);

      // Check if the response contains a 'Message' key with the value 'Address saved.'
      // and a 'Success' key with the value 'true' to determine success.
      if (response['Message'] == 'Address saved.' &&
          response['Success'] == true) {
        // If the conditions are met, emit the CreateAddressSuccessfull state.
        emit(CreateAddressSuccessfull());
      }
    } on SocketException {
      // If a SocketException is caught, emit the CreateAddressInternetError state
      // to handle network-related errors.
      emit(CreateAddressInternetError());
    } on TimeoutException {
      // If a TimeoutException is caught, emit the CreateAddressTimeout state
      // to handle timeout errors.
      emit(CreateAddressTimeout());
    } catch (e) {
      // If any other exception is caught, emit the CreateAddressFailed state
      // to indicate a general failure.
      emit(CreateAddressFailed());
    }
  }
}

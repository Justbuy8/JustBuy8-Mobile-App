// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';
part 'delete_address_state.dart';

// Define a class named DeleteAddressCubit that extends the Cubit class
// with the generic type DeleteAddressState.
class DeleteAddressCubit extends Cubit<DeleteAddressState> {
  // Constructor for the DeleteAddressCubit class.
  // It initializes the cubit with the DeleteAddressInitial state.
  DeleteAddressCubit() : super(DeleteAddressInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare a dynamic variable named response.
  dynamic response;

  // Define an asynchronous function named deleteAddress that takes an 'addressId' parameter.
  deleteAddress(addressId) async {
    // Emit the DeleteAddressLoading state to indicate that an operation is in progress.
    emit(DeleteAddressLoading());

    try {
      // Create a new map named 'newAddressMap' with the 'addressId' as a key-value pair.
      var newAddressMap = {
        "address_id": addressId,
      };

      // Call the deleteAddress method from the AddressController class
      // with the 'newAddressMap' as a parameter and assign the result to the 'response' variable.
      response = await AddressController.deleteAddress(newAddressMap);

      // Check if the response contains a 'Message' key with the value 'Address Deleted.'
      // and a 'Success' key with the value 'true' to determine success.
      if (response['Message'] == 'Address Deleted.' &&
          response['Success'] == true) {
        // If the conditions are met, emit the DeleteAddressSuccessfull state.
        emit(DeleteAddressSuccessfull());
      }
    } on SocketException {
      // If a SocketException is caught, emit the DeleteAddressInternetError state
      // to handle network-related errors.
      emit(DeleteAddressInternetError());
    } on TimeoutException {
      // If a TimeoutException is caught, emit the DeleteAddressTimeout state
      // to handle timeout errors.
      emit(DeleteAddressTimeout());
    } catch (e) {
      // If any other exception is caught, emit the DeleteAddressFailed state
      // to indicate a general failure.
      emit(DeleteAddressFailed());
    }
  }
}

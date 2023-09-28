// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';
part 'registration_state.dart';

// Define a class named RegistrationCubit that extends the Cubit class
// with the generic type RegistrationState.
class RegistrationCubit extends Cubit<RegistrationState> {
  // Constructor for the RegistrationCubit class.
  // It initializes the cubit with the RegistrationInitial state.
  RegistrationCubit() : super(RegistrationInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare a dynamic variable named 'response'.
  dynamic response;

  // Define an asynchronous function named userRegistration that takes a 'body' parameter.
  userRegistration(body) async {
    // Emit the RegistrationLoading state to indicate that the registration operation is in progress.
    emit(RegistrationLoading());
    try {
      // Call the registration method from the AuthenticationController class
      // with the 'body' as a parameter and assign the result to the 'response' variable.
      response = await AuthenticationController.registration(body);

      // Check if the registration was successful.
      if (response['Success'] == true) {
        // Store the authentication token securely.
        await UserSecureStorage.setToken(response["Data"]["Token"].toString());

        // Emit the RegistrationSuccessfull state to indicate a successful registration.
        emit(RegistrationSuccessfull());
      }
    } on SocketException {
      // Emit the RegistrationInternetError state to handle network-related errors.
      emit(RegistrationInternetError());
    } on TimeoutException {
      // Emit the RegistrationTimeout state to handle timeout errors.
      emit(RegistrationTimeout());
    } catch (e) {
      // Emit the RegistrationFailed state with an error message when registration fails.
      emit(RegistrationFailed(errorMessage: response['Message']));
    }
  }
}

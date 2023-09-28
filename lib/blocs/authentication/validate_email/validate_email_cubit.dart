// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'validate_email_state.dart';

class ValidateEmailCubit extends Cubit<ValidateEmailState> {
  // Constructor for the ValidateEmailCubit class.
  ValidateEmailCubit() : super(ValidateEmailInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to validate an email address.
  validateEmail(email) async {
    // Emit a loading state to indicate that validation is in progress.
    emit(ValidateEmailLoading());
    try {
      // Call the getEmailVerification method from the AuthenticationController.
      response = await AuthenticationController.getEmailVerification(email);

      // Check the response for different scenarios.
      if (response['Message'] == 'Email is not exist' &&
          response['Success'] == true) {
        // If the email does not exist and the request was successful, emit success state.
        emit(ValidateEmailSuccessfuly());
      } else if (response['Message'] == 'Email already exist' &&
          response['Success'] == false) {
        // If the email already exists and the request failed, emit already exist state.
        emit(ValidateEmailAlreadyExist());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(ValidateEmailInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(ValidateEmailTimeOut());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(ValidateEmailFailed());
    }
  }
}

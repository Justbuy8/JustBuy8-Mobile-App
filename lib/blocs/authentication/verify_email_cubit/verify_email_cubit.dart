// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  // Constructor for the VerifyEmailCubit class.
  VerifyEmailCubit() : super(VerifyEmailInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to verify an email using a token.
  verifyEmail(email, token) async {
    // Emit a loading state to indicate that email verification is in progress.
    emit(VerifyEmailLoading());
    try {
      // Call the verifyEmailOtp method from the AuthenticationController.
      response = await AuthenticationController.verifyEmailOtp(email, token);

      // Check the response for different scenarios.
      if (response['Success'] == true) {
        // If the email verification was successful, emit success state.
        emit(VerifyEmailSuccessfuly());
      } else if (response['Success'] == false) {
        // If the email verification failed, emit a failure state.
        emit(VerifyEmailFailed());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(VerifyEmailInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(VerifyEmailTimeOut());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(VerifyEmailFailed());
    }
  }
}

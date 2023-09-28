// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

// Define a class named ResetPasswordCubit that extends the Cubit class
// with the generic type ResetPasswordState.
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  // Constructor for the ResetPasswordCubit class.
  // It initializes the cubit with the ResetPasswordInitial state.
  ResetPasswordCubit() : super(ResetPasswordInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare a dynamic variable named 'response'.
  dynamic response;

  // Define an asynchronous function named resetPassword that takes 'email' and 'password' parameters.
  resetPassword(email, password) async {
    // Emit the ResetPasswordLoading state to indicate that the password reset operation is in progress.
    emit(ResetPasswordLoading());
    try {
      // Call the resetEmail method from the AuthenticationController class
      // with 'email' and 'password' as parameters and assign the result to the 'response' variable.
      response = await AuthenticationController.resetEmail(email, password);

      // Check if the password reset was successful.
      if (response['Success'] == true) {
        // Emit the ResetPasswordSuccessfuly state to indicate a successful password reset.
        emit(ResetPasswordSuccessfuly());
      } else if (response['Success'] == false) {
        // Emit the ResetPasswordFailed state to indicate a failed password reset.
        emit(ResetPasswordFailed());
      }
    } on SocketException {
      // Emit the ResetPasswordInternetError state to handle network-related errors.
      emit(ResetPasswordInternetError());
    } on TimeoutException {
      // Emit the ResetPasswordTimeOut state to handle timeout errors.
      emit(ResetPasswordTimeOut());
    } catch (e) {
      // Emit the ResetPasswordFailed state to handle any other exceptions that may occur during the reset process.
      emit(ResetPasswordFailed());
    }
  }
}

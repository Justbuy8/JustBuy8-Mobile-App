// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import "package:flutter_bloc/flutter_bloc.dart";
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

part 'login_state.dart';

// Define a class named LoginCubit that extends the Cubit class
// with the generic type LoginState.
class LoginCubit extends Cubit<LoginState> {
  // Constructor for the LoginCubit class.
  // It initializes the cubit with the LoginInitial state.
  LoginCubit() : super(LoginInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare dynamic variables named 'response' and 'notificationResponse'.
  dynamic response;
  dynamic notificationResponse;

  // Define an asynchronous function named userLogin that takes a 'loginBody' parameter.
  userLogin(loginBody) async {
    try {
      // Emit the LoginLoading state to indicate that the login operation is in progress.
      emit(LoginLoading());

      // Call the login method from the AuthenticationController class
      // with the 'loginBody' as a parameter and assign the result to the 'response' variable.
      response = await AuthenticationController.login(loginBody);

      // Check if the login was successful.
      if (response['Success'] == true) {
        // Store the authentication token securely.
        await UserSecureStorage.setToken(response["Data"]['Token'].toString());

        // Get the push notification token from OneSignal.
        final status = await OneSignal.User.pushSubscription.token;
        var notificationBody = {"push_token": "${status.toString()}"};

        // Register the push notification token on the server.
        notificationResponse =
            await AuthenticationController.notificationTokenRegistration(
          notificationBody,
        );

        // Check if the push notification token registration was successful.
        if (notificationResponse['Success'] == true) {
          // Emit the LoginSuccessfull state to indicate a successful login.
          emit(LoginSuccessfull());
        } else if (notificationResponse["Success"] == false) {
          // Emit the LoginFailed state with an error message when push token registration fails.
          emit(LoginFailed(errorMessage: notificationResponse["Message"]));
        }
      } else if (response["Success"] == false) {
        // Emit the LoginFailed state with an error message when login fails.
        emit(LoginFailed(errorMessage: response["Message"]));
      }
    } on SocketException {
      // Emit the LoginInternetError state to handle network-related errors.
      emit(LoginInternetError());
    } on TimeoutException {
      // Emit the LoginTimeout state to handle timeout errors.
      emit(LoginTimeout());
    } catch (e) {
      // Handle any other exceptions that may occur during the login process.
      if (response["Success"] == true &&
          notificationResponse["Success"] == false) {
        // Emit the LoginFailed state with an error message when push token registration fails.
        emit(LoginFailed(errorMessage: notificationResponse["Message"]));
      } else {
        // Emit the LoginFailed state with an error message when other exceptions occur.
        emit(LoginFailed(errorMessage: response["Message"]));
      }
    }
  }
}

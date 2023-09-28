// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'send_otp_state.dart';

// Define a class named SendOtpCubit that extends the Cubit class
// with the generic type SendOtpState.
class SendOtpCubit extends Cubit<SendOtpState> {
  // Constructor for the SendOtpCubit class.
  // It initializes the cubit with the SendOtpInitial state.
  SendOtpCubit() : super(SendOtpInitial());

  // Create an instance of the ApiManager class.
  ApiManager apiManager = ApiManager();

  // Declare dynamic variables named 'response' and 'otpCode'.
  dynamic response;
  String? otpCode;

  // Define an asynchronous function named sendOtp that takes an 'email' parameter.
  sendOtp(email) async {
    // Emit the SendOtpLoading state to indicate that the OTP sending operation is in progress.
    emit(SendOtpLoading());
    try {
      // Call the sendOtpCode method from the AuthenticationController class
      // with the 'email' as a parameter and assign the result to the 'response' variable.
      response = await AuthenticationController.sendOtpCode(email);

      // Check if the OTP code was sent successfully.
      if (response['Message'] == 'Code Sent' && response['Success'] == true) {
        // Store the OTP code from the response.
        otpCode = response["Data"]["Code"].toString();

        // Emit the SendOtpSuccessfuly state to indicate a successful OTP code sending.
        emit(SendOtpSuccessfuly());
      }
    } on SocketException {
      // Emit the SendOtpInternetError state to handle network-related errors.
      emit(SendOtpInternetError());
    } on TimeoutException {
      // Emit the SendOtpTimeOut state to handle timeout errors.
      emit(SendOtpTimeOut());
    } catch (e) {
      // Emit the SendOtpFailed state to handle any other exceptions that may occur during the OTP sending process.
      emit(SendOtpFailed());
    }
  }
}

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(SendOtpInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;
  String? otpCode;

  sendOtp(email) async {
    emit(SendOtpLoading());
    try {
      response = await AuthenticationController.sendOtpCode(email);

      if (response['Message'] == 'Code Sent' && response['Success'] == true) {
        otpCode = response["Data"]["Code"].toString();

        emit(SendOtpSuccessfuly());
      }
    } on SocketException {
      emit(SendOtpInternetError());
    } on TimeoutException {
      emit(SendOtpTimeOut());
    } catch (e) {
      emit(SendOtpFailed());
    }
  }
}

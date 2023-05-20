// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  verifyEmail(email, token) async {
    emit(VerifyEmailLoading());
    try {
      response = await AuthenticationController.verifyEmailOtp(email, token);
      if (response['Success'] == true) {
        emit(VerifyEmailSuccessfuly());
      } else if (response['Success'] == false) {
        emit(VerifyEmailFailed());
      }
    } on SocketException {
      emit(VerifyEmailInternetError());
    } on TimeoutException {
      emit(VerifyEmailTimeOut());
    } catch (e) {
      emit(VerifyEmailFailed());
    }
  }
}

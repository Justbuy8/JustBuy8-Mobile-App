// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  resetPassword(email, password) async {
    emit(ResetPasswordLoading());
    try {
      response = await AuthenticationController.resetEmail(email, password);
      if (response['Success'] == true) {
        emit(ResetPasswordSuccessfuly());
      } else if (response['Success'] == false) {
        emit(ResetPasswordFailed());
      }
    } on SocketException {
      emit(ResetPasswordInternetError());
    } on TimeoutException {
      emit(ResetPasswordTimeOut());
    } catch (e) {
      emit(ResetPasswordFailed());
    }
  }
}

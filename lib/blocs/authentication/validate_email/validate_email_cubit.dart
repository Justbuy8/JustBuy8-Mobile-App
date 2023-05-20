// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'validate_email_state.dart';

class ValidateEmailCubit extends Cubit<ValidateEmailState> {
  ValidateEmailCubit() : super(ValidateEmailInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  validateEmail(email) async {
    emit(ValidateEmailLoading());
    try {
      response = await AuthenticationController.getEmailVerification(email);
      if (response['Message'] == 'Email is not exist' &&
          response['Success'] == true) {
        emit(ValidateEmailSuccessfuly());
      } else if (response['Message'] == 'Email already exist' &&
          response['Success'] == false) {
        emit(ValidateEmailAlreadyExist());
      }
    } on SocketException {
      emit(ValidateEmailInternetError());
    } on TimeoutException {
      emit(ValidateEmailTimeOut());
    } catch (e) {
      emit(ValidateEmailFailed());
    }
  }
}

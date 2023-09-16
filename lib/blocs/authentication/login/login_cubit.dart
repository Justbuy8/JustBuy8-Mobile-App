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

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  ApiManager apiManager = ApiManager();
  dynamic response;
  dynamic notificationResponse;

  userLogin(loginBody) async {
    try {
      emit(LoginLoading());
      response = await AuthenticationController.login(loginBody);

      if (response['Success'] == true) {
        await UserSecureStorage.setToken(response["Data"]['Token'].toString());
        final status = await OneSignal.User.pushSubscription.token;
        var notificationBody = {"push_token": "${status.toString()}"};

        notificationResponse =
            await AuthenticationController.notificationTokenRegistration(
          notificationBody,
        );
        if (notificationResponse['Success'] == true) {
          emit(LoginSuccessfull());
        } else if (notificationResponse["Success"] == false) {
          emit(LoginFailed(errorMessage: notificationResponse["Message"]));
        }
      } else if (response["Success"] == false) {
        emit(LoginFailed(errorMessage: response["Message"]));
      }
    } on SocketException {
      emit(LoginInternetError());
    } on TimeoutException {
      emit(LoginTimeout());
    } catch (e) {
      if (response["Success"] == true &&
          notificationResponse["Success"] == false) {
        emit(LoginFailed(errorMessage: notificationResponse["Message"]));
      } else {
        emit(LoginFailed(errorMessage: response["Message"]));
      }
    }
  }
}

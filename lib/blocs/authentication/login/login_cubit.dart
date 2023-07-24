// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import "package:flutter_bloc/flutter_bloc.dart";
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  ApiManager apiManager = ApiManager();
  dynamic response;

  userLogin(loginBody) async {
    try {
      emit(LoginLoading());
      response = await AuthenticationController.login(loginBody);

      if (response['Message'][0] == 'Login Success' &&
          response['Success'] == true) {
        // await UserSecureStorage.setUserId(
        //     response["Data"]["UserId"].toString());
        await UserSecureStorage.setToken(response["Data"].toString());

        emit(LoginSuccessfull());
      } else if (response['Message'] == 'Invalid email or password' &&
          response['Success'] == false) {
        emit(LoginFailed());
      }
    } on SocketException {
      emit(LoginInternetError());
    } on TimeoutException {
      emit(LoginTimeout());
    } catch (e) {
      emit(LoginFailed());
    }
  }
}

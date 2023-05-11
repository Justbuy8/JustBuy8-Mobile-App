import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:justbuyeight/controllers/authentication/auth_controller.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  userRegistration(body) async {
    try {
      response = await AuthenticationController.registration(body);

      if (response['Message'] == 'Register Success' &&
          response['Success'] == true) {
        await UserSecureStorage.setUserId(
            response["Data"]["UserId"].toString());
        await UserSecureStorage.setToken(response["Data"]["Token"].toString());

        emit(RegistrationSuccessfull());
      }
    } on SocketException {
      emit(RegistrationInternetError());
    } on TimeoutException {
      emit(RegistrationTimeout());
    } catch (e) {
      emit(RegistrationFailed());
    }
  }
}

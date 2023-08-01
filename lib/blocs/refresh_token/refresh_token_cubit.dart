import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/refresh_token/token_controller.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit() : super(RefreshTokenInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  refreshAuthToken() async {
    try {
      emit(RefreshTokenLoading());
      response = await TokenController.refreshAuthToken();

      if (response['Success'] == true) {
        await UserSecureStorage.setToken(response["Data"]['Token'].toString());
        emit(RefreshTokenUpdated());
      } else if (response["Success"] == false) {
        emit(RefreshTokenNotUpdated());
      }
    } on SocketException {
      emit(RefreshTokenInternetError());
    } catch (e) {
      emit(RefreshTokenNotUpdated());
    }
  }
}

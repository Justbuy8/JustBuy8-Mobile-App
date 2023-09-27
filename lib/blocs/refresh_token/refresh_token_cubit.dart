import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/refresh_token/token_controller.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  // Constructor for the RefreshTokenCubit class.
  RefreshTokenCubit() : super(RefreshTokenInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to refresh the authentication token.
  refreshAuthToken() async {
    try {
      // Emit a loading state to indicate that token refresh is in progress.
      emit(RefreshTokenLoading());

      // Call the refreshAuthToken method from the TokenController.
      response = await TokenController.refreshAuthToken();

      // Check the response for success.
      if (response['Success'] == true) {
        // Set the new token in secure storage.
        await UserSecureStorage.setToken(response["Data"]['Token'].toString());

        // Emit a state indicating that the token has been updated.
        emit(RefreshTokenUpdated());
      } else if (response["Success"] == false) {
        // Emit a state indicating that the token refresh was not successful.
        emit(RefreshTokenNotUpdated());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(RefreshTokenInternetError());
    } catch (e) {
      // Handle other exceptions by emitting a state indicating token refresh failure.
      emit(RefreshTokenNotUpdated());
    }
  }
}

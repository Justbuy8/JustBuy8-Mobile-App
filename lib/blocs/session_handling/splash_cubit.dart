// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/utils/Secure_Storage.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';

part 'splash_state.dart';

class SessionHandlingCubit extends Cubit<SessionHandlingState> {
  // Constructor for the SessionHandlingCubit class.
  SessionHandlingCubit() : super(SessionHandlingInitial());

  // Method to initialize the app's initial route based on session state.
  initliazeRoute() async {
    try {
      // Check if there is an internet connection.
      bool connectionValue = await isNetworkAvailable();

      if (connectionValue) {
        // Fetch the user token from secure storage.
        String? userToken = await UserSecureStorage.fetchToken();

        // Fetch the "newUser" status from secure storage.
        String? newUser = await UserSecureStorage.fetchNewUser();

        if (userToken != null && newUser != null) {
          // If a user token and "newUser" status are present, navigate to the home screen.
          emit(SessionHandlingHomeScreen());
        } else if (userToken == null && newUser != null) {
          // If no user token but "newUser" status is present, navigate to the login screen.
          emit(SessionHandlingLoginScreen());
        } else {
          // If no user token and no "newUser" status, navigate to the onboarding screen.
          emit(SessionHandlingOnBoarding());
        }
      } else {
        // If there is no internet connection, emit a failed state.
        emit(SessionHandlingFailed());
      }
    } catch (e) {
      // Handle any exceptions by emitting a failed state.
      emit(SessionHandlingFailed());
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/myaccount/myaccount.dart';
part 'update_user_profile_state.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  // Constructor for the UpdateUserProfileCubit class.
  UpdateUserProfileCubit() : super(UpdateUserProfileInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to update user profile information.
  updateUserProfile(firstName, lastName, phoneNumber) async {
    // Emit a loading state to indicate that the profile update is in progress.
    emit(UpdateUserProfileLoading());
    try {
      // Create a map with updated profile information.
      var updateProfileMap = {
        "f_name": "$firstName",
        "l_name": "$lastName",
        "phone": "$phoneNumber"
      };

      // Call the updateUserData method from the MyAccountController.
      response = await MyAccountController.updateUserData(updateProfileMap);

      // Check the response for success or failure.
      if (response['Success'] == true) {
        // If the profile update was successful, emit a success state.
        emit(UpdateUserProfileSuccess());
      } else if (response['Success'] == false) {
        // If the profile update failed, emit a failure state.
        emit(UpdateUserProfileFailed());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(UpdateUserProfileInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(UpdateUserProfileTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(UpdateUserProfileFailed());
    }
  }
}

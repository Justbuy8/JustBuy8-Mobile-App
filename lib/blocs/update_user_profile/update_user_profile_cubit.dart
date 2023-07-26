// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/myaccount/myaccount.dart';
part 'update_user_profile_state.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  UpdateUserProfileCubit() : super(UpdateUserProfileInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  updateUserProfile(firstName, lastName, phoneNumber) async {
    emit(UpdateUserProfileLoading());
    try {
      var updateProfileMap = {
        "f_name": "$firstName",
        "l_name": "$lastName",
        "phone": "$phoneNumber"
      };

      response = await MyAccountController.updateUserData(updateProfileMap);

      if (response['Success'] == true) {
        emit(UpdateUserProfileSuccess());
      } else if (response['Success'] == false) {
        emit(UpdateUserProfileFailed());
      }
    } on SocketException {
      emit(UpdateUserProfileInternetError());
    } on TimeoutException {
      emit(UpdateUserProfileTimeout());
    } catch (e) {
      emit(UpdateUserProfileFailed());
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/myaccount/myaccount.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  uploadImage(file) async {
    emit(UploadImageLoading());
    try {
      //String? userId = await UserSecureStorage.fetchUserId();
      String? token = await UserSecureStorage.fetchToken();

      response = await MyAccountController.uploadImage(token, file);

      if (response['Success'] == true) {
        emit(UploadImageUploaded());
      } else if (response['Success'] == false) {
        emit(UploadImageFailed());
      }
    } on SocketException {
      emit(UploadImageInternetError());
    } on TimeoutException {
      emit(UploadImageTimeout());
    } catch (e) {
      emit(UploadImageFailed());
    }
  }
}

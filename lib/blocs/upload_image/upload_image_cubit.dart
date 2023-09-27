// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/myaccount/myaccount.dart';
import 'package:justbuyeight/utils/secure_storage.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  // Constructor for the UploadImageCubit class.
  UploadImageCubit() : super(UploadImageInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to upload an image.
  uploadImage(file) async {
    // Emit a loading state to indicate that the image upload is in progress.
    emit(UploadImageLoading());
    try {
      // Fetch the user token from secure storage.
      String? token = await UserSecureStorage.fetchToken();

      // Call the uploadImage method from the MyAccountController.
      response = await MyAccountController.uploadImage(token, file);

      // Check the response for success or failure.
      if (response['Success'] == true) {
        // If the image upload was successful, emit a success state.
        emit(UploadImageUploaded());
      } else if (response['Success'] == false) {
        // If the image upload failed, emit a failure state.
        emit(UploadImageFailed());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(UploadImageInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(UploadImageTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      print(e); // Print the error for debugging purposes.
      emit(UploadImageFailed());
    }
  }
}

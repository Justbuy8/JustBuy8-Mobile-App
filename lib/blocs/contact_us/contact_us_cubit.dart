import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/support/support.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  // Constructor for the ContactUsCubit class.
  ContactUsCubit() : super(ContactUsInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to allow a user to contact customer support.
  userContactUs(subject, message) async {
    // Emit a loading state to indicate that the contact request is in progress.
    emit(ContactUsLoading());
    try {
      // Prepare the request body with subject and message.
      var body = {
        "subject": subject,
        "message": message,
      };

      // Call the contactUs method from the SupportController.
      response = await SupportController.contactUs(body);

      // Check the response for success.
      if (response['Success'] == true) {
        // If the contact request was successful, emit a success state.
        emit(ContactUsSuccessfull());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(ContactUsInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(ContactUsTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(ContactUsFailed());
    }
  }
}

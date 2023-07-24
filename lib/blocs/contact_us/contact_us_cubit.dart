import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/support/support.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  userContactUs(subject, message) async {
    emit(ContactUsLoading());
    try {
      var body = {
        "subject": "New Testing",
        "message": "Checking the Api working"
      };
      response = await SupportController.contactUs(body);

      if (response['Success'] == true) {
        emit(ContactUsSuccessfull());
      }
    } on SocketException {
      emit(ContactUsInternetError());
    } on TimeoutException {
      emit(ContactUsTimeout());
    } catch (e) {
      emit(ContactUsFailed());
    }
  }
}

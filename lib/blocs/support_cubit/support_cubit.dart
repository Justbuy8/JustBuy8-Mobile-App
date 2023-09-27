import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/support/support.dart';
import 'package:justbuyeight/models/support/support_model.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  // Method to fetch support-related data.
  getSupportData() async {
    emit(SupportLoading());
    try {
      // Call the static method from SupportController to retrieve support-related data.
      response = await SupportController.getSupportData();

      // Check if the response indicates success.
      if (response['Success'] == true) {
        print(response);
        // Parse the response JSON into a SupportModel object.
        var decodedList = SupportModel.fromJson(response);

        // Emit the SupportLoaded state with the retrieved support data.
        emit(SupportLoaded(supportData: [decodedList]));
      } else if (response['Success'] == false) {
        // Emit the SupportFailed state if the response indicates failure.
        emit(SupportFailed());
      }
    } on SocketException {
      // Emit the SupportInternetError state if there's a socket exception.
      emit(SupportInternetError());
    } on TimeoutException {
      // Emit the SupportTimeout state if there's a timeout exception.
      emit(SupportTimeout());
    } catch (e) {
      // Emit the SupportFailed state for other exceptions.
      emit(SupportFailed());
    }
  }
}

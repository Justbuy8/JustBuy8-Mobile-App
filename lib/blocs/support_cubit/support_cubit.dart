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

  getSupportData() async {
    emit(SupportLoading());
    try {
      response = await SupportController.getSupportData();
      if (response['Success'] == true) {
        print(response);
        var decodedList = SupportModel.fromJson(response);

        emit(SupportLoaded(supportData: [decodedList]));
      } else if (response['Success'] == false) {
        emit(SupportFailed());
      }
    } on SocketException {
      emit(SupportInternetError());
    } on TimeoutException {
      emit(SupportTimeout());
    } catch (e) {
      emit(SupportFailed());
    }
  }
}

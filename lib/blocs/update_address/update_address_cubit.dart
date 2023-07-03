// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UpdateAddressCubit() : super(UpdateAddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  updateAddress(body) async {
    emit(UpdateAddressLoading());
    try {
      response = await AddressController.updateAddress(body);
      if (response['Message'] == 'Address Updated.' &&
          response['Success'] == true) {
        emit(UpdateAddressSuccessfull());
      }
    } on SocketException {
      emit(UpdateAddressInternetError());
    } on TimeoutException {
      emit(UpdateAddressTimeout());
    } catch (e) {
      emit(UpdateAddressFailed());
    }
  }
}

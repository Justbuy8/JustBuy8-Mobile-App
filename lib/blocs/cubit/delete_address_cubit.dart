import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';

part 'delete_address_state.dart';

class DeleteAddressCubit extends Cubit<DeleteAddressState> {
  DeleteAddressCubit() : super(DeleteAddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  deleteAddress(body) async {
    emit(DeleteAddressLoading());
    try {
      response = await AddressController.deleteAddress(body);

      if (response['Message'] == 'Address Deleted.' &&
          response['Success'] == true) {
        emit(DeleteAddressSuccessfull());
      }
    } on SocketException {
      emit(DeleteAddressInternetError());
    } on TimeoutException {
      emit(DeleteAddressTimeout());
    } catch (e) {
      emit(DeleteAddressFailed());
    }
  }
}

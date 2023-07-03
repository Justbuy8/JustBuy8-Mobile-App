// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';

part 'create_address_state.dart';

class CreateAddressCubit extends Cubit<CreateAddressState> {
  CreateAddressCubit() : super(CreateAddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  createNewAddress(body) async {
    emit(CreateAddressLoading());
    try {
      response = await AddressController.createAddress(body);

      if (response['Message'] == 'Address saved.' &&
          response['Success'] == true) {
        emit(CreateAddressSuccessfull());
      }
    } on SocketException {
      emit(CreateAddressInternetError());
    } on TimeoutException {
      emit(CreateAddressTimeout());
    } catch (e) {
      emit(CreateAddressFailed());
    }
  }
}

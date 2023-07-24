// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/secure_storage.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';
import 'package:justbuyeight/models/myaddress/my_address_model.dart';

part 'get_address_state.dart';

class GetAddressCubit extends Cubit<GetAddressState> {
  GetAddressCubit() : super(GetAddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  getAddress() async {
    emit(GetAddressLoading());
    try {
      String? token = await UserSecureStorage.fetchToken();

      response = await AddressController.getAddress();

      if (response['Success'] == true &&
          response['Message'] == 'Addresses Found.') {
        var decodedList = AddressModel.fromJson(response);

        emit(GetAddressLoaded(addressData: [decodedList]));
      } else if (response['Success'] == false) {
        emit(GetAddressFailed());
      }
    } on SocketException {
      emit(GetAddressInternetError());
    } on TimeoutException {
      emit(GetAddressTimeout());
    } catch (e) {
      emit(GetAddressFailed());
    }
  }
}

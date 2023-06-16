// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';
import 'package:justbuyeight/models/myaddress/my_address_model.dart';
import 'package:justbuyeight/utils/secure_storage.dart';
part 'myaddress_state.dart';

class GetaddressCubit extends Cubit<GetaddressState> {
  GetaddressCubit() : super(GetaddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  getAddress() async {
    emit(GetaddressLoading());
    try {
      String? userId = await UserSecureStorage.fetchUserId();
      String? token = await UserSecureStorage.fetchToken();
      var body = {"UserId": "${userId}", "Token": "${token}"};

      response = await AddressController.getAddress(body);
      log(response.toString());

      if (response['Success'] == true &&
          response['Message'] == 'Addresses Found.') {
        var decodedList = AddressModel.fromJson(response);

        emit(GetaddressLoaded(addressData: [decodedList]));
      } else if (response['Success'] == false) {
        emit(GetaddressFailed());
      }
    } on SocketException {
      emit(GetaddressInternetError());
    } on TimeoutException {
      emit(GetaddressTimeout());
    } catch (e) {
      print(e);
      emit(GetaddressFailed());
    }
  }
}

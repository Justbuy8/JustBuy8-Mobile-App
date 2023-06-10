// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/addresses/address_controller.dart';
import 'package:justbuyeight/models/myaddress/my_address_model.dart';
import 'package:justbuyeight/utils/secure_storage.dart';
part 'myaddress_state.dart';

class MyaddressCubit extends Cubit<MyaddressState> {
  MyaddressCubit() : super(MyaddressInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  getAddress() async {
    emit(MyaddressLoading());
    try {
      String? userId = await UserSecureStorage.fetchUserId();
      String? token = await UserSecureStorage.fetchToken();
      var body = {"UserId": "${userId}", "Token": "${token}"};

      response = await AddressController.getAddress(body);
      if (response['Success'] == true) {
        var decodedList = AddressModel.fromJson(response);

        emit(MyaddressLoaded(addressData: [decodedList]));
      } else if (response['Success'] == false) {
        emit(MyaddressFailed());
      }
    } on SocketException {
      emit(MyaddressInternetError());
    } on TimeoutException {
      emit(MyaddressTimeout());
    } catch (e) {
      emit(MyaddressFailed());
    }
  }
}

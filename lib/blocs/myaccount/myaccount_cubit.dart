// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/myaccount/myaccount.dart';
import 'package:justbuyeight/models/myaccount/myaccount_model.dart';
import 'package:meta/meta.dart';

part 'myaccount_state.dart';

class MyaccountCubit extends Cubit<MyaccountState> {
  MyaccountCubit() : super(MyaccountInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  myAccount() async {
    emit(MyaccountLoading());
    try {
      response = await MyAccountController.getAccountData();
      if (response['Success'] == true) {
        var decodedList = MyAccountModel.fromJson(response);

        emit(MyaccountLoaded(accountData: [decodedList]));
      } else if (response['Success'] == false) {
        emit(MyaccountFailed());
      }
    } on SocketException {
      emit(MyaccountInternetError());
    } on TimeoutException {
      emit(MyaccountTimeout());
    } catch (e) {
      emit(MyaccountFailed());
    }
  }
}

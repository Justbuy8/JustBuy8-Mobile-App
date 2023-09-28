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
  // Constructor for the MyaccountCubit class.
  MyaccountCubit() : super(MyaccountInitial());

  // Create an instance of ApiManager for making API requests.
  ApiManager apiManager = ApiManager();

  // Variable to store the response from the API.
  dynamic response;

  // Method to fetch account data.
  myAccount() async {
    // Emit a loading state to indicate that account data is being fetched.
    emit(MyaccountLoading());
    try {
      // Call the getAccountData method from the MyAccountController.
      response = await MyAccountController.getAccountData();

      // Check the response for success.
      if (response['Success'] == true) {
        // Parse the response into a MyAccountModel and emit the loaded state.
        var decodedList = MyAccountModel.fromJson(response);
        emit(MyaccountLoaded(accountData: [decodedList]));
      } else if (response['Success'] == false) {
        // If the request was not successful, emit a failure state.
        emit(MyaccountFailed());
      }
    } on SocketException {
      // Handle SocketException: No internet connection.
      emit(MyaccountInternetError());
    } on TimeoutException {
      // Handle TimeoutException: Request timeout.
      emit(MyaccountTimeout());
    } catch (e) {
      // Handle other exceptions by emitting a generic failure state.
      emit(MyaccountFailed());
    }
  }
}

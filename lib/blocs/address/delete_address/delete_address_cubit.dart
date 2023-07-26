// ignore_for_file: depend_on_referenced_packages
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

  deleteAddress(addressId) async {
    emit(DeleteAddressLoading());
    try {
      var newAddressMap = {
        "address_id": addressId,
      };
      response = await AddressController.deleteAddress(newAddressMap);

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

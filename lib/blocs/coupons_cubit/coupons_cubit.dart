import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/controllers/coupons/coupons_controller.dart';
import 'package:justbuyeight/models/coupons/coupons_model.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  CouponsCubit() : super(CouponsInitial());

  ApiManager apiManager = ApiManager();
  dynamic response;

  getCoupons() async {
    emit(CouponsLoading());
    try {
      response = await CouponsController.getCoupons();
      print(response);

      if (response['Success'] == true &&
          response['Message'] == 'Coupons Found') {
        var decodedList = GetCouponsModel.fromJson(response);

        emit(CouponsLoaded(couponsData: [decodedList]));
      } else if (response['Success'] == true &&
          response['Message'] == 'No Coupons Found') {
        emit(GetNoCouponsFound());
      }
    } on SocketException {
      emit(CouponsInternetError());
    } on TimeoutException {
      emit(CouponsTimeout());
    } catch (e) {
      emit(CouponsFailed());
    }
  }
}

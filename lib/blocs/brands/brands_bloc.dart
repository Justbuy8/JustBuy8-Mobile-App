import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/brands/brands_controller.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  List<BrandsModel> brands = [];

  BrandsBloc() : super(BrandsInitState()) {
    on<BrandsLoadEvent>((event, emit) async {
      // Emit the loaing state first, until we get the data from the API.
      emit(BrandsLoadingState());
      try {
        // calling the api to get the data from the API
        final brands = await BrandsController.getBrands(
          event.page,
          event.paginateBy,
          event.random,
        );
        // if we get the data from the API then we should emit the data
        // otherwise we should emit the empty array or list.
        if (brands.isNotEmpty) {
          emit(BrandsGetState(brands));
        } else {
          emit(BrandsEmptyState(AppText.noBrandsFountText));
        }
      } catch (e) {
        if (e is SocketException) {
          emit(BrandsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(BrandsErrorState(AppText.serverError));
        } else {
          emit(BrandsErrorState(e.toString()));
        }
      }
    });
  }
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/new_arrival_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  NewArrivalBloc() : super(NewArrivalLoadingState()) {
    List<ProductModel> products = [];
    on<NewArrivalGetInitialData>((event, emit) async {
      emit(NewArrivalLoadingState());
      try {
        products = await NewArrivalController.getNewArrivals(
          event.page,
          event.paginateBy,
          event.categoryId,
        );

        if (products.isEmpty) {
          emit(
            NewArrivalEmptyState(),
          );
          return;
        }
        emit(NewArrivalGetAllState(products));
      } catch (e) {
        if (e is SocketException) {
          emit(NewArrivalErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(NewArrivalErrorState(AppText.serverError));
        } else {
          emit(NewArrivalErrorState(e.toString()));
        }
      }
    });

    // Get more data
    on<NewArrivalGetMoreData>((event, emit) async {
      emit(NewArrivalLoadingMoreState());
      try {
        products = await NewArrivalController.getNewArrivals(
          event.page,
          event.paginateBy,
          event.categoryId,
        );

        emit(NewArrivalGetAllState(products));
      } catch (e) {
        // if (e is SocketException) {
        //   emit(NewArrivalErrorState(AppText.internetError));
        // } else if (e is HttpException) {
        //   emit(NewArrivalErrorState(AppText.serverError));
        // } else {
        //   emit(NewArrivalErrorState(e.toString()));
        // }
      }
    });
  }
}

// Import necessary libraries and files
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/brands/brands_controller.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';

// Create a BLoC class for managing brands
class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  List<BrandsModel> brands = [];

  BrandsBloc() : super(BrandsInitState()) {
    on<BrandsLoadEvent>((event, emit) async {
      // Emit the loading state first, until we get the data from the API.
      emit(BrandsLoadingState());
      try {
        // Call the API to get the data
        final brands = await BrandsController.getBrands(
          event.page,
          event.paginateBy,
          event.random,
        );

        // If we get the data from the API, emit the data state,
        // otherwise, emit an empty state.
        if (brands.isNotEmpty) {
          emit(BrandsGetState(brands));
        } else {
          emit(BrandsEmptyState(AppText.noBrandsToLoadText));
        }
      } catch (e) {
        // Handle errors, such as internet connection issues, server errors, or others
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

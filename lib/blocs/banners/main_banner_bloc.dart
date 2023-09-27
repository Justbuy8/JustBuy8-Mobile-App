// Import necessary libraries and files
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

// Define abstract states that will be handled in the frontend
abstract class MainBannerState {}

class MainBannerInitial extends MainBannerState {}

class MainBannerLoadingState extends MainBannerState {}

class MainBannerDataState extends MainBannerState {
  final List<BannerModel> bannerModel;
  MainBannerDataState(this.bannerModel);
}

class MainBannerNoDataState extends MainBannerState {
  final List<BannerModel> bannerModel;
  MainBannerNoDataState(this.bannerModel);
}

class MainBannerErrorState extends MainBannerState {
  final String message;
  MainBannerErrorState(this.message);
}

// Define abstract events that will be fired on specific actions
abstract class MainBannerEvent {}

class MainBannerLoadingEvent extends MainBannerEvent {}

// Create a BLoC class for managing the main banner
class MainBannerBloc extends Bloc<MainBannerEvent, MainBannerState> {
  MainBannerBloc() : super(MainBannerInitial()) {
    List<BannerModel> model;

    // Define what happens when the MainBannerLoadingEvent is triggered
    on<MainBannerLoadingEvent>((event, emit) async {
      // Show loading on the screen
      emit(MainBannerLoadingState());

      try {
        // Call the API to get the main banner data
        model = await BannerController.getBanners(isMainBanner: true);

        if (model.isEmpty) {
          // When there is no data available, inform the frontend
          emit(MainBannerNoDataState(model));
        } else {
          // When data is available, provide it to the frontend
          emit(MainBannerDataState(model));
        }
      } catch (e) {
        // Handle errors, such as internet connection issues, server errors, or others
        if (e is SocketException) {
          emit(MainBannerErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(MainBannerErrorState(AppText.serverError));
        } else {
          emit(MainBannerErrorState(e.toString()));
        }
      }
    });
  }
}

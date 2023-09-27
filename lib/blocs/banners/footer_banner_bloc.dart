// Import necessary libraries and files
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

// Define abstract states that will be handled in the frontend
abstract class FooterBannerState {}

class FooterBannerInitial extends FooterBannerState {}

class FooterBannerLoadingState extends FooterBannerState {}

class FooterBannerDataState extends FooterBannerState {
  final List<BannerModel> bannerModel;
  FooterBannerDataState(this.bannerModel);
}

class FooterBannerNoDataState extends FooterBannerState {
  final List<BannerModel> bannerModel;
  FooterBannerNoDataState(this.bannerModel);
}

class FooterBannerErrorState extends FooterBannerState {
  final String message;
  FooterBannerErrorState(this.message);
}

// Define abstract events that will be fired on specific actions
abstract class FooterBannerEvent {}

class FooterBannerLoadingEvent extends FooterBannerEvent {}

// Create a BLoC class for managing the footer banner
class FooterBannerBloc extends Bloc<FooterBannerEvent, FooterBannerState> {
  FooterBannerBloc() : super(FooterBannerInitial()) {
    List<BannerModel> model;

    // Define what happens when the FooterBannerLoadingEvent is triggered
    on<FooterBannerLoadingEvent>((event, emit) async {
      // Show loading on the screen
      emit(FooterBannerLoadingState());

      try {
        // Call the API to get the banner data
        model = await BannerController.getBanners(isMainBanner: false);

        if (model.isEmpty) {
          // When there is no data available, inform the frontend
          emit(FooterBannerNoDataState(model));
        }

        // When data is available, provide it to the frontend
        emit(FooterBannerDataState(model));
      } catch (e) {
        // Handle errors, such as internet connection issues, server errors, or others
        if (e is SocketException) {
          emit(FooterBannerErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(FooterBannerErrorState(AppText.serverError));
        } else {
          emit(FooterBannerErrorState(e.toString()));
        }
      }
    });
  }
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

// states that we will be handling in the front end
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

// events that we will fire on specific events
abstract class FooterBannerEvent {}

class FooterBannerLoadingEvent extends FooterBannerEvent {}

// bloc
class FooterBannerBloc extends Bloc<FooterBannerEvent, FooterBannerState> {
  FooterBannerBloc() : super(FooterBannerInitial()) {
    List<BannerModel> model;

    on<FooterBannerLoadingEvent>((event, emit) async {
      // show loading on the screen
      emit(FooterBannerLoadingState());
      // call the api and get the data from it.
      try {
        model = await BannerController.getBanners(isMainBanner: false);
        if (model.isEmpty) {
          // when there is data available, throw the data to the front end.
          emit(FooterBannerNoDataState(model));
        }
        emit(FooterBannerDataState(model));
      } catch (e) {
        // Handle the error, like internet connection error etc.
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

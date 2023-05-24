import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

// states
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

// events
abstract class FooterBannerEvent {}

class FooterBannerLoadingEvent extends FooterBannerEvent {}

// bloc
class FooterBannerBloc extends Bloc<FooterBannerEvent, FooterBannerState> {
  FooterBannerBloc() : super(FooterBannerInitial()) {
    List<BannerModel> model;

    on<FooterBannerLoadingEvent>((event, emit) async {
      // show loading on the screen
      emit(FooterBannerLoadingState());
      // call the api
      try {
        model = await BannerController.getBanners(isMainBanner: false);
        if (model.isEmpty) {
          emit(FooterBannerNoDataState(model));
        }
        emit(FooterBannerDataState(model));
      } catch (e) {
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

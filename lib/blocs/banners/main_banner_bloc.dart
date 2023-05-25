import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/banners/BannerController.dart';
import 'package:justbuyeight/models/banners/BannerModel.dart';

// states
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

// events
abstract class MainBannerEvent {}

class MainBannerLoadingEvent extends MainBannerEvent {}

// bloc
class MainBannerBloc extends Bloc<MainBannerEvent, MainBannerState> {
  MainBannerBloc() : super(MainBannerInitial()) {
    List<BannerModel> model;

    on<MainBannerLoadingEvent>((event, emit) async {
      // show loading on the screen
      emit(MainBannerLoadingState());
      // call the api
      try {
        model = await BannerController.getBanners(isMainBanner: true);
        if (model.isEmpty) {
          emit(MainBannerNoDataState(model));
        } else {
          emit(MainBannerDataState(model));
        }
      } catch (e) {
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

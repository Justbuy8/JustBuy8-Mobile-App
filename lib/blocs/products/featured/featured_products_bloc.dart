import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured/featured_products_events_and_states.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/featured_products_controller.dart';

class FeaturedProductsBloc
    extends Bloc<FeaturedProductsEvent, FeaturedProductsState> {
  FeaturedProductsBloc() : super(FeaturedProductsInitState()) {
    on<FeaturedProductsLoadEvent>((event, emit) async {
      emit(FeaturedProductsInitState());
      try {
        final products = await FeaturedProductsController.getFeaturedProducts(
            event.page, event.paginateBy, event.random);
        emit(FeaturedProductsGetState(products));
      } catch (e) {
        if (e is SocketException) {
          emit(FeaturedProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(FeaturedProductsErrorState(AppText.serverError));
        } else {
          emit(FeaturedProductsErrorState(e.toString()));
        }
      }
    });
  }
}

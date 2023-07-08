import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/main_category_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

part 'main_category_products_states_events.dart';

class MainCategoryProductsBloc
    extends Bloc<MainCategoryProductsEvent, MainCategoryProductsState> {
  MainCategoryProductsBloc() : super(MainCategoryProductsInitState()) {
    List<ProductModel> products = [];
    on<MainCategoryProductsLoadEvent>((event, emit) async {
      emit(MainCategoryProductsInitState());
      try {
        products = await MainCategoryProductsController.getProducts(
            event.page, event.paginateBy, event.categoryId);
        emit(MainCategoryProductsGetState(products));
      } catch (e) {
        if (e is SocketException) {
          emit(MainCategoryProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(MainCategoryProductsErrorState(AppText.serverError));
        } else {
          emit(MainCategoryProductsErrorState(e.toString()));
        }
      }
    });
  }
}

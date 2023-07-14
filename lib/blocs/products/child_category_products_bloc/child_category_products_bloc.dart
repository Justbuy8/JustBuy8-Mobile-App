import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/child_category_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

part 'child_category_products_states_events.dart';

class ChildCategoryProductsBloc
    extends Bloc<ChildCategoryProductsEvent, ChildCategoryProductsState> {
  ChildCategoryProductsBloc() : super(ChildCategoryProductsInitState()) {
    List<ProductModel> products = [];
    on<ChildCategoryProductsLoadEvent>((event, emit) async {
      emit(ChildCategoryProductsInitState());
      try {
        products = await ChildCategoryProductsController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
          categoryId: event.categoryId,
          subCategoryId: event.subCategoryId,
          childCategoryId: event.childCategoryId,
        );
        emit(ChildCategoryProductsGetState(products));
      } catch (e) {
        if (e is SocketException) {
          emit(ChildCategoryProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(ChildCategoryProductsErrorState(AppText.serverError));
        } else {
          emit(ChildCategoryProductsErrorState(e.toString()));
        }
      }
    });
  }
}

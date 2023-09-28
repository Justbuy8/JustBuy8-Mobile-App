import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/child_category_products_controller.dart';
import 'package:justbuyeight/models/products/ProductModel.dart';

// Define a Bloc class for managing the state of child category products.
part 'child_category_products_states_events.dart';

class ChildCategoryProductsBloc
    extends Bloc<ChildCategoryProductsEvent, ChildCategoryProductsState> {
  ChildCategoryProductsBloc() : super(ChildCategoryProductsInitState()) {
    List<ProductModel> products = [];
    on<ChildCategoryProductsLoadEvent>((event, emit) async {
      // Emit the initial state to indicate that data is being fetched.
      emit(ChildCategoryProductsInitState());
      try {
        // Fetch child category products using the controller.
        products = await ChildCategoryProductsController.getProducts(
          page: event.page,
          paginateBy: event.paginateBy,
          categoryId: event.categoryId,
          subCategoryId: event.subCategoryId,
          childCategoryId: event.childCategoryId,
        );
        // Emit the state with the fetched products.
        emit(ChildCategoryProductsGetState(products));
      } catch (e) {
        // Handle potential exceptions (error handling).
        if (e is SocketException) {
          // Emit an error state with an internet connectivity message.
          emit(ChildCategoryProductsErrorState(AppText.internetError));
        } else if (e is HttpException) {
          // Emit an error state with a server error message.
          emit(ChildCategoryProductsErrorState(AppText.serverError));
        } else {
          // Emit an error state with a generic error message.
          emit(ChildCategoryProductsErrorState(e.toString()));
        }
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/best/best_products_states_and_events.dart';
import 'package:justbuyeight/controllers/products/best_products_controller.dart';

class BestProductsBloc extends Bloc<BestProductsEvent, BestProductsState> {
  BestProductsBloc() : super(BestProductsLoadingState()) {
    on<BestProductsGetAllEvent>((event, emit) async {
      emit(BestProductsLoadingState());
      try {
        final products = await BestProductsController.getBestProducts(
          event.page,
          event.paginateBy,
          event.random,
        );

        if (products.isEmpty) {
          emit(
            BestProductsEmptyState(),
          );
          return;
        }
        emit(BestProductsGetAllState(products));
      } catch (error) {
        emit(BestProductsErrorState(error.toString()));
      }
    });
  }
}

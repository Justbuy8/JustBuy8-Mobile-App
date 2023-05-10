import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/featured_products_events_and_states.dart';
import 'package:justbuyeight/controllers/products/featured_products_controller.dart';

class FeaturedProductsBloc
    extends Bloc<FeaturedProductsEvent, FeaturedProductsState> {
  FeaturedProductsBloc() : super(FeaturedProductsInitState()) {
    on<FeaturedProductsEvent>((event, emit) async {
      if (event is FeaturedProductsLoadEvent) {
        try {
          final products =
              await FeaturedProductsController.getFeaturedProducts();
          emit(FeaturedProductsGetState(products));
        } catch (error) {
          emit(FeaturedProductsErrorState(error.toString()));
        }
      }
    });
  }
}

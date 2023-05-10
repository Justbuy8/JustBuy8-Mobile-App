import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/products/featured_products_controller.dart';
import 'package:justbuyeight/models/products/featured_products_model.dart';

// events
abstract class FeaturedProductsEvent {}

class FeaturedProductsLoadEvent extends FeaturedProductsEvent {}

//states
abstract class FeaturedProductsState {}

class FeaturedProductsInitState extends FeaturedProductsState {}

class FeaturedProductsGetState extends FeaturedProductsState {
  final List<FeaturedProductsModel> products;
  FeaturedProductsGetState(this.products);
}

class FeaturedProductsErrorState extends FeaturedProductsState {
  final String message;
  FeaturedProductsErrorState(this.message);
}

// bloc
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

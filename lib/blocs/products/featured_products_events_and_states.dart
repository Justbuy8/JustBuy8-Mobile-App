// events
import 'package:justbuyeight/models/products/featured_products_model.dart';

abstract class FeaturedProductsEvent {}

class FeaturedProductsLoadEvent extends FeaturedProductsEvent {
 final String page;
 final String paginate_by;

  FeaturedProductsLoadEvent(this.page, this.paginate_by);
}

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

// events
import 'package:justbuyeight/models/brands/brands_model.dart';

abstract class BrandsEvent {}

class BrandsLoadEvent extends BrandsEvent {
  final String page;
  final String paginateBy;
  final bool random;

  BrandsLoadEvent(this.page, this.paginateBy, this.random);
}

//states
abstract class BrandsState {}

class BrandsInitState extends BrandsState {}

class BrandsLoadingState extends BrandsState {}

class BrandsGetState extends BrandsState {
  final List<BrandsModel> brands;
  BrandsGetState(this.brands);
}

class BrandsEmptyState extends BrandsState {
  final String message;
  BrandsEmptyState(this.message);
}

class BrandsErrorState extends BrandsState {
  final String message;
  BrandsErrorState(this.message);
}

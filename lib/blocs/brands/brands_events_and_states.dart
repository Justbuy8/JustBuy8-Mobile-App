// events
import 'package:justbuyeight/models/brands/brands_model.dart';

abstract class BrandsEvent {}

class BrandsLoadEvent extends BrandsEvent {
  final String page;
  final String paginateBy;

  BrandsLoadEvent(this.page, this.paginateBy);
}

//states
abstract class BrandsState {}

class BrandsInitState extends BrandsState {}

class BrandsLoadingState extends BrandsState {}

class BrandsGetState extends BrandsState {
  final List<BrandsModel> brands;
  BrandsGetState(this.brands);
}

class BrandsErrorState extends BrandsState {
  final String message;
  BrandsErrorState(this.message);
}

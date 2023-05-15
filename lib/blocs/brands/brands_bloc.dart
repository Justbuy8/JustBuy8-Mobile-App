import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/controllers/brands/brands_controller.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(BrandsInitState()) {
    on<BrandsLoadEvent>((event, emit) async {
      emit(BrandsInitState());
      try {
        final products = await BrandsController.getBrands(
          event.page,
          event.paginateBy,
        );
        emit(BrandsGetState(products));
      } catch (error) {
        emit(BrandsErrorState(error.toString()));
      }
    });
  }
}

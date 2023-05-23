import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/brands/brands_events_and_states.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/brands/brands_controller.dart';
import 'package:justbuyeight/models/brands/brands_model.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  List<BrandsModel> brands = [];

  BrandsBloc() : super(BrandsInitState()) {
    on<BrandsLoadEvent>((event, emit) async {
      emit(BrandsLoadingState());
      try {
        final brands = await BrandsController.getBrands(
          event.page,
          event.paginateBy,
          event.random,
        );
        if (brands.isNotEmpty) {
          emit(BrandsGetState(brands));
        } else {
          emit(BrandsEmptyState(AppText.noBrandsFountText));
        }
      } catch (error) {
        emit(BrandsErrorState(error.toString()));
      }
    });
  }
}

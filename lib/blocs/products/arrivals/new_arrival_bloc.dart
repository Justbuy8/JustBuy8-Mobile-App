import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/blocs/products/arrivals/new_arrival_state_and_events.dart';
import 'package:justbuyeight/controllers/products/new_arrival_controller.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  NewArrivalBloc() : super(NewArrivalLoadingState()) {
    on<NewArrivalGetAllEvent>((event, emit) async {
      emit(NewArrivalLoadingState());
      try {
        final products = await NewArrivalController.getNewArrivals(
          event.page,
          event.paginateBy,
          event.categoryId,
        );

        if (products.isEmpty) {
          emit(NewArrivalEmptyState());
          return;
        }
        emit(NewArrivalGetAllState(products));
      } catch (error) {
        emit(NewArrivalErrorState(error.toString()));
      }
    });
  }
}

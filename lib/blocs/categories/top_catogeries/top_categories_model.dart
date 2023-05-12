import 'package:flutter_bloc/flutter_bloc.dart';

// EVENTS
abstract class TopCategoriesEvent {}

class TopCategoriesLoadingEvent extends TopCategoriesEvent {}

// STATES
abstract class TopCategoriesState {}

class TopCategoriesLoadingState extends TopCategoriesState {}

class TopCategoriesDataState extends TopCategoriesState {}

class TopCategoriesErrorState extends TopCategoriesState {}

// BLOC
class TopCategoriesBloc extends Bloc<TopCategoriesEvent, TopCategoriesState> {
  TopCategoriesBloc() : super(TopCategoriesLoadingState()) {
    on<TopCategoriesLoadingEvent>((event, emit) {
      try {
        emit(TopCategoriesLoadingState());
      } catch (error) {
        emit(TopCategoriesErrorState());
      }
    });
  }
}

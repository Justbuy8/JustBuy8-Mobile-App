import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';

// EVENTS
abstract class RatingFilterEvent {}

class RatingFilterLoadingEvent extends RatingFilterEvent {}

// STATES
abstract class RatingFilterState {}

class RatingFilterLoadingState extends RatingFilterState {}

class RatingFilterDataState extends RatingFilterState {
  final List<String> ratings;
  RatingFilterDataState(this.ratings);
}

class RatingFilterErrorState extends RatingFilterState {
  final String error;
  RatingFilterErrorState({this.error = AppText.noCategoriesFoundText});
}

// BLOC
class RatingFilterBloc extends Bloc<RatingFilterEvent, RatingFilterState> {
  RatingFilterBloc() : super(RatingFilterLoadingState()) {
    List<String> ratings = [
      "All",
      "1",
      "2",
      "3",
      "4",
      "5",
    ];

    on<RatingFilterLoadingEvent>((event, emit) async {
      try {
        emit(RatingFilterDataState(ratings));
      } catch (e) {
        if (e is SocketException) {
          emit(RatingFilterErrorState(error: AppText.internetError));
        } else if (e is HttpException) {
          emit(RatingFilterErrorState(error: AppText.serverError));
        } else {
          emit(RatingFilterErrorState(error: e.toString()));
        }
      }
    });
  }
}

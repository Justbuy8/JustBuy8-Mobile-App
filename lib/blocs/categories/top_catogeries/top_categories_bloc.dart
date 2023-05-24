import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

// EVENTS
abstract class TopCategoriesEvent {}

class TopCategoriesLoadingEvent extends TopCategoriesEvent {}

// STATES
abstract class TopCategoriesState {}

class TopCategoriesLoadingState extends TopCategoriesState {}

class TopCategoriesDataState extends TopCategoriesState {
  final List<CategoryModel> topCategories;
  TopCategoriesDataState(this.topCategories);
}

class TopCategoriesErrorState extends TopCategoriesState {
  final String errorMessage;
  TopCategoriesErrorState(this.errorMessage);
}

// BLOC
class TopCategoriesBloc extends Bloc<TopCategoriesEvent, TopCategoriesState> {
  TopCategoriesBloc() : super(TopCategoriesLoadingState()) {
    on<TopCategoriesLoadingEvent>((event, emit) async {
      try {
        emit(TopCategoriesDataState(
          await CategoryController.getTopCategories("1", "8"),
        ));
      } catch (e) {
        if (e is SocketException) {
          emit(TopCategoriesErrorState(AppText.internetError));
        } else if (e is HttpException) {
          emit(TopCategoriesErrorState(AppText.serverError));
        } else {
          emit(TopCategoriesErrorState(e.toString()));
        }
      }
    });
  }
}

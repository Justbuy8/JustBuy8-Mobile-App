import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

// EVENTS
abstract class FilterCategoriesEvent {}

class FilterCategoriesLoadingEvent extends FilterCategoriesEvent {
  final String page;
  final String paginateBy;
  final bool random;
  FilterCategoriesLoadingEvent({
    required this.page,
    required this.paginateBy,
    required this.random,
  });
}

// STATES
abstract class FilterCategoriesState {}

class FilterCategoriesLoadingState extends FilterCategoriesState {}

class FilterCategoriesDataState extends FilterCategoriesState {
  final List<CategoryModel> filterCategories;
  FilterCategoriesDataState(this.filterCategories);
}

class FilterCategoriesErrorState extends FilterCategoriesState {
  final String error;
  FilterCategoriesErrorState({this.error = AppText.noCategoriesFoundText});
}

// BLOC
class FilterCategoriesBloc
    extends Bloc<FilterCategoriesEvent, FilterCategoriesState> {
  FilterCategoriesBloc() : super(FilterCategoriesLoadingState()) {
    List<CategoryModel> categories = [];

    on<FilterCategoriesLoadingEvent>((event, emit) async {
      try {
        categories = await CategoryController.getMainCategories(
          event.page,
          event.paginateBy,
          event.random,
        );
        categories.insert(
            0,
            CategoryModel(
              catId: "all",
              catName: "All",
            ));
        emit(FilterCategoriesDataState(categories));
      } catch (e) {
        if (e is SocketException) {
          emit(FilterCategoriesErrorState(error: AppText.internetError));
        } else if (e is HttpException) {
          emit(FilterCategoriesErrorState(error: AppText.serverError));
        } else {
          emit(FilterCategoriesErrorState(error: e.toString()));
        }
      }
    });
  }
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

// EVENTS
abstract class MainCategoryEvent {}

class MainCategoryLoadingEvent extends MainCategoryEvent {
  final String page;
  final String paginateBy;
  final bool random;
  MainCategoryLoadingEvent({
    required this.page,
    required this.paginateBy,
    required this.random,
  });
}

// STATES
abstract class MainCategoryState {}

class MainCategoryLoadingState extends MainCategoryState {}

class MainCategoryDataState extends MainCategoryState {
  final List<CategoryModel> mainCategory;
  MainCategoryDataState(this.mainCategory);
}

class MainCategoryErrorState extends MainCategoryState {
  final String error;
  MainCategoryErrorState({this.error = AppText.noCategoriesFoundText});
}

// BLOC
class MainCategoryBloc extends Bloc<MainCategoryEvent, MainCategoryState> {
  MainCategoryBloc() : super(MainCategoryLoadingState()) {
    List<CategoryModel> categories = [];

    on<MainCategoryLoadingEvent>((event, emit) async {
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
        emit(MainCategoryDataState(categories));
      } catch (e) {
        if (e is SocketException) {
          emit(MainCategoryErrorState(error: AppText.internetError));
        } else if (e is HttpException) {
          emit(MainCategoryErrorState(error: AppText.serverError));
        } else {
          emit(MainCategoryErrorState(error: e.toString()));
        }
      }
    });
  }
}

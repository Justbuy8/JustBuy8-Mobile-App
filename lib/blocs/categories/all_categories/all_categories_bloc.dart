import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

// EVENTS
abstract class AllCategoryEvent {}

class AllCategoriesGetEvent extends AllCategoryEvent {
  final String page;
  final String paginateBy;
  AllCategoriesGetEvent({required this.page, required this.paginateBy});
}

// STATES
abstract class AllCategoryState {}

class AllCategoryLoadingState extends AllCategoryState {}

class AllCategoryDataState extends AllCategoryState {
  final List<CategoryModel> allCategory;
  AllCategoryDataState(this.allCategory);
}

class AllCategoryErrorState extends AllCategoryState {
  final String error;
  AllCategoryErrorState({this.error = AppText.noCategoriesFoundText});
}

// BLOC
class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  AllCategoryBloc() : super(AllCategoryLoadingState()) {
    List<CategoryModel> categories = [];

    on<AllCategoriesGetEvent>((event, emit) async {
      try {
        categories = await CategoryController.getMainCategories(
          event.page,
          event.paginateBy,
        );
        emit(AllCategoryDataState(categories));
      } catch (e) {
        if (e is SocketException) {
          emit(AllCategoryErrorState(error: AppText.internetError));
        } else if (e is HttpException) {
          emit(AllCategoryErrorState(error: AppText.serverError));
        } else {
          emit(AllCategoryErrorState(error: e.toString()));
        }
      }
    });
  }
}

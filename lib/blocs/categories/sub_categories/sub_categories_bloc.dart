import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/SubCategoryModel.dart';

// EVENTS
abstract class SubCategoryEvent {}

class SubCategoryLoadingEvent extends SubCategoryEvent {
  final int categoryId;
  SubCategoryLoadingEvent(this.categoryId);
}

class SubCategoryChildClickedEvent extends SubCategoryEvent {
  final int index;
  SubCategoryChildClickedEvent(this.index);
}

// STATES
abstract class SubCategoryState {}

class SubCategoryInitialState extends SubCategoryState {}

class SubCategoryLoadingState extends SubCategoryState {}

class SubCategoryDataState extends SubCategoryState {
  final List<SubCategoryModel> subCategories;
  SubCategoryDataState(this.subCategories);
}

class SubCategoryErrorState extends SubCategoryState {
  final String error;
  SubCategoryErrorState({this.error = AppText.noCategoriesFoundText});
}

class SubCategoryChildClickedState extends SubCategoryState {
  final int index;
  SubCategoryChildClickedState(this.index);
}

// BLOC
class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  SubCategoryBloc() : super(SubCategoryInitialState()) {
    List<SubCategoryModel> categories = [];

    on<SubCategoryLoadingEvent>((event, emit) async {
      emit(SubCategoryLoadingState());
      try {
        categories = await CategoryController.getSubCategories(
          event.categoryId,
        );
        emit(SubCategoryDataState(categories));
      } catch (e) {
        if (e is SocketException) {
          emit(SubCategoryErrorState(error: AppText.internetError));
        } else if (e is HttpException) {
          emit(SubCategoryErrorState(error: AppText.serverError));
        } else {
          emit(SubCategoryErrorState(error: e.toString()));
        }
      }
    });

    on<SubCategoryChildClickedEvent>(
      (event, emit) {
        emit(SubCategoryChildClickedState(event.index));
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/categories/CategoryController.dart';
import 'package:justbuyeight/models/categories/CategoryModel.dart';

// EVENTS
abstract class MainCategoryEvent {}

class MainCategoryLoadingEvent extends MainCategoryEvent {
  final String page;
  final String paginateBy;
  MainCategoryLoadingEvent({required this.page, required this.paginateBy});
}

// STATES
abstract class MainCategoryState {}

class MainCategoryLoadingState extends MainCategoryState {}

class MainCategoryDataState extends MainCategoryState {
  final List<CategoriesModel> mainCategory;
  MainCategoryDataState(this.mainCategory);
}

class MainCategoryErrorState extends MainCategoryState {}

// BLOC
class MainCategoryBloc extends Bloc<MainCategoryEvent, MainCategoryState> {
  MainCategoryBloc() : super(MainCategoryLoadingState()) {
    on<MainCategoryLoadingEvent>((event, emit) async {
      try {
        emit(MainCategoryDataState(
          await CategoryController.getMainCategories(
            event.page,
            event.paginateBy,
          ),
        ));
      } catch (error) {
        emit(MainCategoryErrorState());
      }
    });
  }
}

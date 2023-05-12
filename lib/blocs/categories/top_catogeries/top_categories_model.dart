import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/controllers/categories/top_categories_controller.dart';
import 'package:justbuyeight/models/categories/top_categories_model.dart';

// EVENTS
abstract class TopCategoriesEvent {}

class TopCategoriesLoadingEvent extends TopCategoriesEvent {}

// STATES
abstract class TopCategoriesState {}

class TopCategoriesLoadingState extends TopCategoriesState {}

class TopCategoriesDataState extends TopCategoriesState {
  final List<TopCategoriesModel> topCategories;
  TopCategoriesDataState(this.topCategories);
}

class TopCategoriesErrorState extends TopCategoriesState {}

// BLOC
class TopCategoriesBloc extends Bloc<TopCategoriesEvent, TopCategoriesState> {
  TopCategoriesBloc() : super(TopCategoriesLoadingState()) {
    on<TopCategoriesLoadingEvent>((event, emit) async {
      try {
        emit(TopCategoriesDataState(
          await CategoriesController.getTopCategories("1", "8"),
        ));
      } catch (error) {
        emit(TopCategoriesErrorState());
      }
    });
  }
}

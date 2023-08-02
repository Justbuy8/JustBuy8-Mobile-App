import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/product_reviews_controller.dart';
import 'package:justbuyeight/models/products/ReviewModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'reviews_states_events.dart';

class ReviewBloc extends Bloc<ReviewsEvent, ReviewState> {
  ReviewBloc() : super(ReviewsInitialState()) {
    List<ReviewModel> reviews = [];
    on<GetReviewsEvent>((event, emit) async {
      emit(ReviewsLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(ReviewsErrorState(message: AppText.internetError));
        }
        reviews = await ProductReviewController.getReviews(event.productId);
        emit(ReviewsLoadedState(reviews: reviews));
      } catch (e) {
        emit(ReviewsErrorState(message: e.toString()));
      }
    });
  }
}

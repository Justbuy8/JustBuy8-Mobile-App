import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/controllers/products/product_reviews_controller.dart';
import 'package:justbuyeight/models/products/ReviewModel.dart';
import 'package:nb_utils/nb_utils.dart';

// Define a Bloc class for managing the state of product reviews.
part 'reviews_states_events.dart';

class ReviewBloc extends Bloc<ReviewsEvent, ReviewState> {
  ReviewBloc() : super(ReviewsInitialState()) {
    List<ReviewModel> reviews = [];

    // Handle the event to get product reviews.
    on<GetReviewsEvent>((event, emit) async {
      // Emit a loading state to indicate that data is being fetched.
      emit(ReviewsLoadingState());

      try {
        // Check if there is internet connectivity.
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          // Emit an error state for no internet connectivity.
          emit(ReviewsErrorState(message: AppText.internetError));
        }

        // Fetch product reviews using the controller.
        reviews = await ProductReviewController.getReviews(event.productId);
        if (reviews.isEmpty || reviews.length == 0) {
          // Emit an empty state if there are no reviews.
          emit(ReviewsEmptyState(message: AppText.noReviewsText));
        } else {
          // Emit a loaded state with the fetched reviews.
          emit(ReviewsLoadedState(reviews: reviews));
        }
      } catch (e) {
        // Emit an error state for any exceptions.
        emit(ReviewsErrorState(message: e.toString()));
      }
    });
  }
}

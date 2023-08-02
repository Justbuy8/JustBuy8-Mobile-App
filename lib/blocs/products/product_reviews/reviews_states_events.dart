part of 'reviews_bloc.dart';

// Events
abstract class ReviewsEvent {}

class GetReviewsEvent extends ReviewsEvent {
  final int productId;
  GetReviewsEvent({required this.productId});
}

// States

abstract class ReviewState {}

class ReviewsInitialState extends ReviewState {}

class ReviewsLoadingState extends ReviewState {}

class ReviewsLoadedState extends ReviewState {
  final List<ReviewModel> reviews;
  ReviewsLoadedState({required this.reviews});
}

class ReviewsErrorState extends ReviewState {
  final String message;
  ReviewsErrorState({required this.message});
}

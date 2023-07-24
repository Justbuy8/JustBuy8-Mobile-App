part of 'add_to_wishlist_bloc.dart';

abstract class AddToWishlistEvent {}

class AddToWishlistOnClickEvent extends AddToWishlistEvent {
  final String productId;

  AddToWishlistOnClickEvent({required this.productId});
}

// States
abstract class AddToWishlistState {}

class AddToWishlistInitState extends AddToWishlistState {}

class AddToWishlistLoadingState extends AddToWishlistState {}

class AddToWishlistSuccessState extends AddToWishlistState {
  final String message;

  AddToWishlistSuccessState(this.message);
}

class AddToWishlistErrorState extends AddToWishlistState {
  final String error;

  AddToWishlistErrorState(this.error);
}

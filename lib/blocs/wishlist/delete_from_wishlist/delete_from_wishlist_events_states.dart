part of 'delete_from_wishlist_bloc.dart';

abstract class DeleteFromWishlistEvent {}

class DeleteFromWishlistOnClickEvent extends DeleteFromWishlistEvent {
  final String productId;

  DeleteFromWishlistOnClickEvent({required this.productId});
}

// States
abstract class DeleteFromWishlistState {}

class DeleteFromWishlistInitState extends DeleteFromWishlistState {}

class DeleteFromWishlistLoadingState extends DeleteFromWishlistState {}

class DeleteFromWishlistSuccessState extends DeleteFromWishlistState {
  final String message;
  final String productId;

  DeleteFromWishlistSuccessState(this.message, this.productId);
}

class DeleteFromWishlistErrorState extends DeleteFromWishlistState {
  final String error;

  DeleteFromWishlistErrorState(this.error);
}

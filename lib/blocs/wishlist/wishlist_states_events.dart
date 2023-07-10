part of 'wishlist_bloc.dart';

// events

abstract class WishlistEvent {}

class WishlistGetDataEvent extends WishlistEvent {
  final String userId;
  final String userToken;
  final int page;
  final int paginateBy;

  WishlistGetDataEvent(
    this.userId,
    this.userToken, {
    required this.page,
    required this.paginateBy,
  });
}

//states
abstract class WishlistState {}

class WishlistInitState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistGetState extends WishlistState {
  final List<ProductModel> products;
  WishlistGetState(this.products);
}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState(this.message);
}

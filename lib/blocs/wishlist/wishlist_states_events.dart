part of 'wishlist_bloc.dart';

// events

abstract class WishlistEvent {}

class WishlistGetInitialData extends WishlistEvent {
  final int page;
  final int paginateBy;

  WishlistGetInitialData({
    required this.page,
    required this.paginateBy,
  });
}

class WishlistGetMoreData extends WishlistEvent {
  final int page;
  final int paginateBy;

  WishlistGetMoreData({
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

class WishlistEmptyState extends WishlistState {}

class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState(this.message);
}

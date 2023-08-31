part of 'get_cart_cubit.dart';

class GetCartState extends Equatable {
  const GetCartState();

  @override
  List<Object> get props => [];
}

class GetCartInitial extends GetCartState {}

class GetCartLoading extends GetCartState {
  final List<GetCartModel> cartData;

  GetCartLoading({required this.cartData});

  List<Object> get props => [cartData];
}

class GetCartLoaded extends GetCartState {
  final List<GetCartModel> cartData;

  GetCartLoaded({required this.cartData});

  List<Object> get props => [];
}

class GetNoCartFound extends GetCartState {}

class GetCartFailed extends GetCartState {}

class GetCartInternetError extends GetCartState {}

class GetCartTimeout extends GetCartState {}

class GetCartQuantityIncreases extends GetCartState {}

class GetCartQuantityIncreasesFailed extends GetCartState {
  final String errorMessage;

  GetCartQuantityIncreasesFailed(this.errorMessage);
}

class GetCartQuantityDecreases extends GetCartState {}

class GetCartQuantityDecreasesFailed extends GetCartState {
  final String errorMessage;

  GetCartQuantityDecreasesFailed(this.errorMessage);
}

class GetCartDeleted extends GetCartState {}

class GetCartCouponSelected extends GetCartState {}

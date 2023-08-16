part of 'shop_details_bloc.dart';

abstract class ShopDetailsEvent {}

class GetShopDetails extends ShopDetailsEvent {
  final int shopId;
  GetShopDetails({required this.shopId});
}

abstract class ShopDetailsState {}

class ShopDetailsInitial extends ShopDetailsState {}

class ShopDetailsLoading extends ShopDetailsState {}

class ShopDetailsLoaded extends ShopDetailsState {
  final ShopDetailsModel shop;
  ShopDetailsLoaded({required this.shop});
}

class ShopDetailsFailed extends ShopDetailsState {
  final String message;
  ShopDetailsFailed({required this.message});
}

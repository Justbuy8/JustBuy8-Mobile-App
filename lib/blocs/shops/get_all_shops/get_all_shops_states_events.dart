part of 'get_all_shops_bloc.dart';

abstract class GetAllShopsEvent {}

class GetAllShops extends GetAllShopsEvent {
  final int page;
  final int paginatedBy;

  GetAllShops({required this.page, required this.paginatedBy});
}

class GetMoreShops extends GetAllShopsEvent {
  final int page;
  final int paginatedBy;

  GetMoreShops({required this.page, required this.paginatedBy});
}

abstract class GetAllShopsState {}

class GetAllShopsInitial extends GetAllShopsState {}

class GetAllShopsLoading extends GetAllShopsState {}

class GetAllShopsMoreLoading extends GetAllShopsState {}

class GetAllShopsSuccess extends GetAllShopsState {
  final List<Shop> shops;

  GetAllShopsSuccess({required this.shops});
}

class GetAllShopsEmpty extends GetAllShopsState {}

class GetAllShopsFailed extends GetAllShopsState {
  final String message;

  GetAllShopsFailed({required this.message});
}

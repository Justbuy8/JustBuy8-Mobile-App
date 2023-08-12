part of 'get_new_shops_bloc.dart';

// Events
abstract class NewShopsEvent {}

class GetNewShopsEvent extends NewShopsEvent {}

// States

abstract class NewShopsState {}

class NewShopsInitialState extends NewShopsState {}

class NewShopsLoadingState extends NewShopsState {}

class NewShopsSuccessState extends NewShopsState {
  final List<Shop> shops;
  NewShopsSuccessState({required this.shops});
}

class NewShopsEmptyState extends NewShopsState {}

class NewShopsErrorState extends NewShopsState {
  final String message;
  NewShopsErrorState({required this.message});
}

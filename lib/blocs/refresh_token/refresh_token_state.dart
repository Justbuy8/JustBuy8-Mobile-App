part of 'refresh_token_cubit.dart';

abstract class RefreshTokenState extends Equatable {
  const RefreshTokenState();

  @override
  List<Object> get props => [];
}

class RefreshTokenInitial extends RefreshTokenState {}

class RefreshTokenLoading extends RefreshTokenState {}

class RefreshTokenUpdated extends RefreshTokenState {}

class RefreshTokenNotUpdated extends RefreshTokenState {}

class RefreshTokenInternetError extends RefreshTokenState {}

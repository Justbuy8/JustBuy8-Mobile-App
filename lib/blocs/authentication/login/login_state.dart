part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfull extends LoginState {}

class LoginFailed extends LoginState {}

class LoginInternetError extends LoginState {}

class LoginTimeout extends LoginState {}

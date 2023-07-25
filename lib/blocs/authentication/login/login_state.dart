part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfull extends LoginState {}

class LoginFailed extends LoginState {
  final List errorMessage;

  LoginFailed({required this.errorMessage});
}

class LoginInternetError extends LoginState {}

class LoginTimeout extends LoginState {}

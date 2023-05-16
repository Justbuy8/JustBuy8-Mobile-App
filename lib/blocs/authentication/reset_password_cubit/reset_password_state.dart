part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccessfuly extends ResetPasswordState {}

class ResetPasswordFailed extends ResetPasswordState {}

class ResetPasswordInternetError extends ResetPasswordState {}

class ResetPasswordTimeOut extends ResetPasswordState {}

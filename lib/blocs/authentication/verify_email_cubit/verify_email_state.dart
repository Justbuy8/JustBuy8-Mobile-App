part of 'verify_email_cubit.dart';

@immutable
abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccessfuly extends VerifyEmailState {}

class VerifyEmailFailed extends VerifyEmailState {}

class VerifyEmailInternetError extends VerifyEmailState {}

class VerifyEmailTimeOut extends VerifyEmailState {}

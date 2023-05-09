part of 'validate_email_cubit.dart';

@immutable
abstract class ValidateEmailState {}

class ValidateEmailInitial extends ValidateEmailState {}

class ValidateEmailLoading extends ValidateEmailState {}

class ValidateEmailSuccessfuly extends ValidateEmailState {}

class ValidateEmailAlreadyExist extends ValidateEmailState {}

class ValidateEmailFailed extends ValidateEmailState {}

class ValidateEmailInternetError extends ValidateEmailState {}

class ValidateEmailTimeOut extends ValidateEmailState {}

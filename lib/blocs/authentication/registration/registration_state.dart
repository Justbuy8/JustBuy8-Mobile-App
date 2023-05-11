part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccessfull extends RegistrationState {}

class RegistrationFailed extends RegistrationState {}

class RegistrationInternetError extends RegistrationState {}

class RegistrationTimeout extends RegistrationState {}

class RegistrationAlreadyExist extends RegistrationState {}
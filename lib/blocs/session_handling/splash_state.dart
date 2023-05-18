part of 'splash_cubit.dart';

@immutable
abstract class SessionHandlingState {}

class SessionHandlingInitial extends SessionHandlingState {}

class SessionHandlingHasData extends SessionHandlingState {}

class SessionHandlingEmpty extends SessionHandlingState {}

class SessionHandlingFailed extends SessionHandlingState {}

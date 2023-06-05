part of 'update_user_profile_cubit.dart';

abstract class UpdateUserProfileState {}

class UpdateUserProfileInitial extends UpdateUserProfileState {}

class UpdateUserProfileLoading extends UpdateUserProfileState {}

class UpdateUserProfileSuccess extends UpdateUserProfileState {}

class UpdateUserProfileFailed extends UpdateUserProfileState {}

class UpdateUserProfileInternetError extends UpdateUserProfileState {}

class UpdateUserProfileTimeout extends UpdateUserProfileState {}

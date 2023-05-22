part of 'myaccount_cubit.dart';

@immutable
abstract class MyaccountState {}

class MyaccountInitial extends MyaccountState {}

class MyaccountLoading extends MyaccountState {}

class MyaccountLoaded extends MyaccountState {
  final List<MyAccountModel> accountData;

  MyaccountLoaded({required this.accountData});

  List<Object> get props => [];
}

class MyaccountFailed extends MyaccountState {}

class MyaccountInternetError extends MyaccountState {}

class MyaccountTimeout extends MyaccountState {}

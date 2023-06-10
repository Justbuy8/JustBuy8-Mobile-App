part of 'myaddress_cubit.dart';

abstract class MyaddressState extends Equatable {
  const MyaddressState();

  @override
  List<Object> get props => [];
}

class MyaddressInitial extends MyaddressState {}

class MyaddressLoading extends MyaddressState {}

class MyaddressLoaded extends MyaddressState {
  final List<AddressModel> addressData;

  MyaddressLoaded({required this.addressData});

  List<Object> get props => [];
}

class MyaddressFailed extends MyaddressState {}

class MyaddressInternetError extends MyaddressState {}

class MyaddressTimeout extends MyaddressState {}

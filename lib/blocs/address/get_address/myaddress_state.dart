part of 'getaddress_cubit.dart';

abstract class GetaddressState extends Equatable {
  const GetaddressState();

  @override
  List<Object> get props => [];
}

class GetaddressInitial extends GetaddressState {}

class GetaddressLoading extends GetaddressState {}

class GetaddressLoaded extends GetaddressState {
  final List<AddressModel> addressData;

  GetaddressLoaded({required this.addressData});

  List<Object> get props => [];
}

class GetaddressFailed extends GetaddressState {}

class GetaddressInternetError extends GetaddressState {}

class GetaddressTimeout extends GetaddressState {}

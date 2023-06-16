part of 'get_address_cubit.dart';

abstract class GetAddressState extends Equatable {
  const GetAddressState();

  @override
  List<Object> get props => [];
}

class GetAddressInitial extends GetAddressState {}

class GetAddressLoading extends GetAddressState {}

class GetAddressLoaded extends GetAddressState {
  final List<AddressModel> addressData;

  GetAddressLoaded({required this.addressData});

  List<Object> get props => [];
}

class GetAddressFailed extends GetAddressState {}

class GetAddressInternetError extends GetAddressState {}

class GetAddressTimeout extends GetAddressState {}

part of 'update_address_cubit.dart';

abstract class UpdateAddressState extends Equatable {
  const UpdateAddressState();

  @override
  List<Object> get props => [];
}

class UpdateAddressInitial extends UpdateAddressState {}

class UpdateAddressLoading extends UpdateAddressState {}

class UpdateAddressSuccessfull extends UpdateAddressState {}

class UpdateAddressFailed extends UpdateAddressState {}

class UpdateAddressInternetError extends UpdateAddressState {}

class UpdateAddressTimeout extends UpdateAddressState {}

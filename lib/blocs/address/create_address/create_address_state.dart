part of 'create_address_cubit.dart';

abstract class CreateAddressState extends Equatable {
  const CreateAddressState();

  @override
  List<Object> get props => [];
}

class CreateAddressInitial extends CreateAddressState {}

class CreateAddressLoading extends CreateAddressState {}

class CreateAddressSuccessfull extends CreateAddressState {}

class CreateAddressFailed extends CreateAddressState {}

class CreateAddressInternetError extends CreateAddressState {}

class CreateAddressTimeout extends CreateAddressState {}

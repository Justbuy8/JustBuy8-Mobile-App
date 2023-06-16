part of 'delete_address_cubit.dart';

abstract class DeleteAddressState extends Equatable {
  const DeleteAddressState();

  @override
  List<Object> get props => [];
}

class DeleteAddressInitial extends DeleteAddressState {}

class DeleteAddressLoading extends DeleteAddressState {}

class DeleteAddressSuccessfull extends DeleteAddressState {}

class DeleteAddressFailed extends DeleteAddressState {}

class DeleteAddressInternetError extends DeleteAddressState {}

class DeleteAddressTimeout extends DeleteAddressState {}

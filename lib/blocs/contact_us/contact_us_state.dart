part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccessfull extends ContactUsState {}

class ContactUsFailed extends ContactUsState {}

class ContactUsInternetError extends ContactUsState {}

class ContactUsTimeout extends ContactUsState {}

class ContactUsAlreadyExist extends ContactUsState {}

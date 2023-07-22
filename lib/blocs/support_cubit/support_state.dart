part of 'support_cubit.dart';

abstract class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => [];
}

class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class SupportLoaded extends SupportState {
  final List<SupportModel> supportData;

  SupportLoaded({required this.supportData});

  List<Object> get props => [];
}

class SupportFailed extends SupportState {}

class SupportInternetError extends SupportState {}

class SupportTimeout extends SupportState {}

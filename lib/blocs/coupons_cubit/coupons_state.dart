part of 'coupons_cubit.dart';

class CouponsState extends Equatable {
  const CouponsState();

  @override
  List<Object> get props => [];
}

class CouponsInitial extends CouponsState {}

class CouponsLoading extends CouponsState {}

class CouponsLoaded extends CouponsState {
  final List<GetCouponsModel> couponsData;

  CouponsLoaded({required this.couponsData});

  List<Object> get props => [];
}

class GetNoCouponsFound extends CouponsState {}

class CouponsFailed extends CouponsState {}

class CouponsInternetError extends CouponsState {}

class CouponsTimeout extends CouponsState {}
